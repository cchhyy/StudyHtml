//
//  MusicViewController.h
//  StudyHtml
//
//  Created by ccyy on 15/7/22.
//  Copyright (c) 2015年 ccyy. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MusicViewController : UIViewController

@property (nonatomic,assign) BOOL playing;


+(instancetype)shareMusicController;
- (IBAction)play:( UIButton *)btn;
-(void)playMusic;


@end
