//
//  ViewController.m
//  AliyunPlayerDemo
//
//  Created by Wuxiaolian on 2018/5/7.
//  Copyright © 2018年 Wu. All rights reserved.
//

#import "ViewController.h"
#import <AliyunPlayerSDK/AlivcMediaPlayer.h>
@interface ViewController ()
@property (nonatomic, strong) AliVcMediaPlayer *mediaPlayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建播放器
    self.mediaPlayer = [[AliVcMediaPlayer alloc] init];
    //创建播放器视图，其中contentView为UIView实例，自己根据业务需求创建一个视图即可
    /*self.mediaPlayer:NSObject类型，需要UIView来展示播放界面。
     self.contentView：承载mediaPlayer图像的UIView类。
     self.contentView = [[UIView alloc] init];
     [self.view addSubview:self.contentView];
     */
    [self.mediaPlayer create:self.view];
    //设置播放类型，0为点播、1为直播，默认使用自动
    self.mediaPlayer.mediaType = MediaType_AUTO;
    //设置超时时间，单位为毫秒
    self.mediaPlayer.timeout = 25000;
    //缓冲区超过设置值时开始丢帧，单位为毫秒。直播时设置，点播设置无效。范围：500～100000
    self.mediaPlayer.dropBufferDuration = 8000;
    //网络视频，填写网络url地址
    NSURL *url = [NSURL URLWithString:@"http://tjtt-output.oss-cn-shanghai.aliyuncs.com/record-out/stream317.mp4?Expires=1525696354&OSSAccessKeyId=rgBGhs03VupDUUGB&Signature=82UsaVaGPQP9uG%2F6ThQp39OzWcM%3D"];
    //prepareToPlay:此方法传入的参数是NSURL类型.
    AliVcMovieErrorCode err = [self.mediaPlayer prepareToPlay:url];
    if(err != ALIVC_SUCCESS) {
        NSLog(@"play failed,error code is %d",(int)err);
        return;
    }
    [self.mediaPlayer play];
    [self addPlayerObserver];

}
#pragma mark - add NSNotification
-(void)addPlayerObserver
{
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(OnVideoPrepared:)
                                                 name:AliVcMediaPlayerLoadDidPreparedNotification object:self.mediaPlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(OnVideoFinish:)
                                                 name:AliVcMediaPlayerPlaybackDidFinishNotification object:self.mediaPlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(OnVideoError:)
                                                 name:AliVcMediaPlayerPlaybackErrorNotification object:self.mediaPlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(OnSeekDone:)
                                                 name:AliVcMediaPlayerSeekingDidFinishNotification object:self.mediaPlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(OnStartCache:)
                                                 name:AliVcMediaPlayerStartCachingNotification object:self.mediaPlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(OnEndCache:)
                                                 name:AliVcMediaPlayerEndCachingNotification object:self.mediaPlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onVideoStop:)
                                                 name:AliVcMediaPlayerPlaybackStopNotification object:self.mediaPlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onVideoFirstFrame:)
                                                 name:AliVcMediaPlayerFirstFrameNotification object:self.mediaPlayer];
    
}

#pragma mark - receive
- (void)OnVideoPrepared:(NSNotification *)notification{
}

- (void)onVideoFirstFrame :(NSNotification *)notification{
    
}
- (void)OnVideoError:(NSNotification *)notification{

}
- (void)OnVideoFinish:(NSNotification *)notification{
    NSLog(@"结束了。。。。。。。。。");
}
- (void)OnSeekDone:(NSNotification *)notification{
}
- (void)OnStartCache:(NSNotification *)notification{
}
- (void)OnEndCache:(NSNotification *)notification{
}

- (void)onVideoStop:(NSNotification *)notification{
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
