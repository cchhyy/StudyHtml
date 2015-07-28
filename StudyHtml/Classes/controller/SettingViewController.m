//
//  SettingViewController.m
//  StudyHtml
//
//  Created by ccyy on 15/7/18.
//  Copyright (c) 2015年 ccyy. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()
{
    UITapGestureRecognizer *_tapRecognizer;
}

@property (weak, nonatomic) IBOutlet UILabel *smallLabel;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    self.view.backgroundColor = [UIColor clearColor];
}








#pragma -mark 点击模态视图外的空白处隐藏模态视图

- (void)viewDidAppear:(BOOL)animated

{
    
    [super viewDidAppear:animated];
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        _tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self  action:@selector(dissmissSelf)];
        [self.view addGestureRecognizer:_tapRecognizer];
        self.smallLabel.text = @"点击屏幕即可返回";
    }else{
        _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapBehind:)];
        
        [_tapRecognizer setNumberOfTapsRequired:1];
        
//            _tapRecognizer.cancelsTouchesInView = NO; //So the user can not  still interact with controls in the modal view
        [self.view.window addGestureRecognizer:_tapRecognizer];
        [_tapRecognizer setDelegate:(id<UIGestureRecognizerDelegate>)self];
    }
}

-(void)dissmissSelf{
    [self dismissViewControllerAnimated:YES completion:nil];
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
