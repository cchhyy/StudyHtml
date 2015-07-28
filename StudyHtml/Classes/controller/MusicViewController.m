//
//  MusicViewController.m
//  StudyHtml
//
//  Created by ccyy on 15/7/22.
//  Copyright (c) 2015年 ccyy. All rights reserved.
//

#import "MusicViewController.h"
#import "FSAudioStream.h"
#import "UIButton+CCYY.h"
#import "FSPlaylistItem.h"

@interface MusicViewController (){
    UITapGestureRecognizer *_tapRecognizer;
    FSAudioStream *_audioStream;
}
@property (strong,nonatomic) NSMutableArray *modelArray;
@property (assign,nonatomic) NSInteger selectIndex;

@end

@implementation MusicViewController
//单例
static MusicViewController *_instance = nil;
+(instancetype)shareMusicController{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init] ;
    }) ;
    
    return _instance ;
}
-(NSMutableArray *)modelArray{
    if (!_modelArray) {
        _modelArray = [[NSMutableArray alloc]initWithObjects:@"http://m1.music.126.net/ZE7bMgL39ly1JZTBaYOFqg==/6628955604505262.mp3",@"http://m1.music.126.net/kAhFZHim0uZ2hx6C32-tqg==/7762552092593411.mp3",@"http://m2.music.126.net/2AiSJewBZozK3A1NcB8y1w==/2015404813722593.mp3",@"http://m1.music.126.net/4sMfsNzMMbG8ciX-uTdM3A==/2801555627580049.mp3",@"http://m1.music.126.net/56f6PhhmcRycrCh5ZTBX_A==/6014328604343505.mp3",@"http://m1.music.126.net/U4AMUON6WC3HVSWAfkczeg==/5631698557584400.mp3",@"http://m1.music.126.net/4sMfsNzMMbG8ciX-uTdM3A==/2801555627580049.mp3",nil];
    }
    return _modelArray;
}
- (IBAction)play:( UIButton *)btn {
    self.playing = !self.playing;
    if ( self.playing) {
        [_audioStream pause];
        NSLog(@"已转为播放模式");
        [btn setNBg:@"playbar_pausebtn_nomal" hBg:@"playbar_pausebtn_click"];
       [_audioStream play];
        
    }else{
        NSLog(@"已转为暂停模式");
        [btn setNBg:@"playbar_playbtn_nomal" hBg:@"playbar_playbtn_click"];
        [_audioStream pause];

    }
}
- (IBAction)previous:(id)sender {
    NSLog(@"上一曲");
    if (self.playing) {
        if (self.selectIndex == 0) {
            self.selectIndex = self.modelArray.count-1;
        }else{
              self.selectIndex--;
        }
        NSLog(@"self.selectIndex ＝ %ld",(long)self.selectIndex);
         [self playMusic];
        [_audioStream play];
    }
   
}
- (IBAction)next:(id)sender {
    NSLog(@"下一曲");
    if (self.playing) {
        if (self.selectIndex == self.modelArray.count-1) {
            self.selectIndex = 0;
        }else{
            self.selectIndex++;
            NSLog(@"self.selectIndex ＝d");
        }
        NSLog(@"self.selectIndex ＝ %ld",(long)self.selectIndex);
 
        [self playMusic];
        [_audioStream play];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self playMusic];
    
}

-(void)prepareToPlayWithUrlString:( NSString *)urlString
{
    _audioStream = [[FSAudioStream alloc]initWithUrl:[NSURL URLWithString:urlString]];
}


-(void)playMusic{
    [self prepareToPlayWithUrlString:self.modelArray[self.selectIndex]];
}






















#pragma -mark 点击模态视图外的空白处隐藏模态视图

- (void)viewDidAppear:(BOOL)animated

{
    
    [super viewDidAppear:animated];
    
    _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapBehind:)];
    
    [_tapRecognizer setNumberOfTapsRequired:1];
    
    _tapRecognizer.cancelsTouchesInView = NO; //So the user can still interact with controls in the modal view
    
    [self.view.window addGestureRecognizer:_tapRecognizer];
    
    [_tapRecognizer setDelegate:(id<UIGestureRecognizerDelegate>)self];
    
}



- (void)handleTapBehind:(UITapGestureRecognizer *)sender

{
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        
        // passing nil gives us coordinates in the window
        
        CGPoint location = [sender locationInView:nil];
        
        // swap (x,y) on iOS 8 in landscape
        
        if ( [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            
            if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
                
                location = CGPointMake(location.y, location.x);
                
            }
            
        }
        
        // convert the tap's location into the local view's coordinate system, and test to see if it's in or outside. If outside, dismiss the view.
        
        if (![self.view pointInside:[self.view convertPoint:location fromView:self.view.window] withEvent:nil]) {
            
            // remove the recognizer first so it's view.window is valid
            
            [self.view.window removeGestureRecognizer:sender];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }
        
    }
    
}



#pragma mark - UIGestureRecognizer Delegate



- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer

{
    
    return YES;
    
}



- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer

{
    
    return YES;
    
}



- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch

{
    
    return YES;
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
