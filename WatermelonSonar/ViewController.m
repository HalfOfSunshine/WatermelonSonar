//
//  ViewController.m
//  WatermelonSonar
//
//  Created by 麻明康 on 2024/7/5.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Accelerate/Accelerate.h>

@interface ViewController ()<AVAudioRecorderDelegate>
@property (nonatomic, strong) UILabel *hzLab;
@property (nonatomic, strong) UILabel *watermelonStateLab;

@property (nonatomic, strong) AVAudioEngine *audioEngine;
@property (nonatomic, strong) AVAudioInputNode *inputNode;
@property (nonatomic, strong) AVAudioFile *audioFile;
@property (nonatomic, strong) AVAudioPCMBuffer *audioBuffer;


@property (nonatomic, strong) AVAudioFormat *format;
@property (nonatomic, assign) FFTSetup fftSetup;
@property (nonatomic, assign) int log2n;
@property (nonatomic, assign) int n;
@property (nonatomic, assign) int nOver2;
@property (nonatomic, assign) float *window;
@property (nonatomic, assign) float *inputBuffer;
@property (nonatomic, assign) DSPSplitComplex *splitComplex;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.hzLab];
    [self.view addSubview:self.watermelonStateLab];
    
    UIButton *startBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, 500, KScreenSize.width-100, 70)];
    [startBtn setTitle:@"开始检测" forState:UIControlStateNormal];
    startBtn.layer.masksToBounds = YES;
    startBtn.layer.cornerRadius = 35;
    startBtn.backgroundColor = [UIColor NFBlue];
    [startBtn addTarget:self action:@selector(startRecording) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    
    UIButton *stopBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, 600, KScreenSize.width-100, 70)];
    [stopBtn setTitle:@"停止检测" forState:UIControlStateNormal];
    stopBtn.layer.masksToBounds = YES;
    stopBtn.layer.cornerRadius = 35;
    stopBtn.backgroundColor = [UIColor LipstickRed];
    [stopBtn addTarget:self action:@selector(stopRecording) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopBtn];

}


#pragma mark =============== 声音检测 ===============
- (BOOL)setupAudioSession {
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *error = nil;
    
    [audioSession setCategory:AVAudioSessionCategoryRecord error:&error];
    [audioSession setMode:AVAudioSessionModeMeasurement error:&error];
    [audioSession setActive:YES error:&error];
    
    if (error) {
        self.hzLab.text = [NSString stringWithFormat:@"Error setting up audio session: %@", error.localizedDescription];
//        NSLog(@"Error setting up audio session: %@", error.localizedDescription);
        return NO;
    }
    return YES;
}

- (void)setupAudioEngine {
    self.audioEngine = [[AVAudioEngine alloc] init];
    self.inputNode = self.audioEngine.inputNode;
    
    self.format = [self.inputNode inputFormatForBus:0];
    
    // Setup FFT
    self.log2n = log2f(self.format.sampleRate);
    self.n = 1 << self.log2n;
    self.nOver2 = self.n / 2;
    self.fftSetup = vDSP_create_fftsetup(self.log2n, FFT_RADIX2);
    
    self.window = (float *)malloc(sizeof(float) * self.n);
    vDSP_hann_window(self.window, self.n, 0);
    
    self.inputBuffer = (float *)malloc(sizeof(float) * self.n);

    // 修改为指针并分配内存
    self.splitComplex = (DSPSplitComplex *)malloc(sizeof(DSPSplitComplex));
    self.splitComplex->realp = (float *)malloc(sizeof(float) * self.nOver2);
    self.splitComplex->imagp = (float *)malloc(sizeof(float) * self.nOver2);
    
    [self.inputNode installTapOnBus:0 bufferSize:1024 format:self.format block:^(AVAudioPCMBuffer *buffer, AVAudioTime *when) {
        [self processAudioBuffer:buffer];
    }];
}


- (void)startRecording {
    
    if (![self setupAudioSession]) return;
    [self setupAudioEngine];
    
    NSError *error = nil;
    [self.audioEngine startAndReturnError:&error];
    
    if (error) {
        self.hzLab.text = [NSString stringWithFormat:@"Error starting audio engine: %@", error.localizedDescription];
    }
}

- (void)processAudioBuffer:(AVAudioPCMBuffer *)buffer {
    AVAudioFrameCount frameCount = buffer.frameLength;
    float *channelData = buffer.floatChannelData[0];
    
    // Apply window and copy data to inputBuffer
    vDSP_vmul(channelData, 1, self.window, 1, self.inputBuffer, 1, frameCount);
    
    // Zero pad if needed
    if (frameCount < self.n) {
        memset(self.inputBuffer + frameCount, 0, sizeof(float) * (self.n - frameCount));
    }
    
    // Perform FFT
    vDSP_ctoz((DSPComplex *)self.inputBuffer, 2, self.splitComplex, 1, self.nOver2);
    vDSP_fft_zrip(self.fftSetup, self.splitComplex, 1, self.log2n, FFT_FORWARD);
    
    // Compute magnitudes
    float magnitudes[self.nOver2];
    vDSP_zvmags(self.splitComplex, 1, magnitudes, 1, self.nOver2);

    float maxMagnitude = 0.0;
    int maxIndex = 0;
    
    for (int i = 0; i < self.nOver2; i++) {
        if (magnitudes[i] > maxMagnitude) {
            maxMagnitude = magnitudes[i];
            maxIndex = i;
        }
    }
    
    float frequency = (float)maxIndex * (self.format.sampleRate / self.n);
    dispatch_async(dispatch_get_main_queue(), ^{
        self.hzLab.text = [NSString stringWithFormat:@"实时频率为: %f Hz", frequency];
    });
}
- (void)stopRecording {
    [self.inputNode removeTapOnBus:0];
    [self.audioEngine stop];
    
    free(self.window);
    free(self.inputBuffer);
    free(self.splitComplex->realp);
    free(self.splitComplex->imagp);
    vDSP_destroy_fftsetup(self.fftSetup);
}

#pragma mark =============== lazy load ===============
- (UILabel *)hzLab{
    if (!_hzLab) {
        _hzLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, KScreenSize.width, 100)];
        _hzLab.backgroundColor = [UIColor lightGrayColor];

    }
    return _hzLab;
}

-(UILabel *)watermelonStateLab{
    if (!_watermelonStateLab) {
        _watermelonStateLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 250, KScreenSize.width, 100)];
        _watermelonStateLab.backgroundColor = [UIColor lightGrayColor];
    }
    return _watermelonStateLab;
}


@end
