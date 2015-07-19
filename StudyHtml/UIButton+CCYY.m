//
//  UIButton+CCYY.m
//  StudyHtml
//
//  Created by ccyy on 15/7/17.
//  Copyright (c) 2015年 ccyy. All rights reserved.
//

#import "UIButton+CCYY.h"

@implementation UIButton (CCYY)
/**
 *  设置未拉伸的正常状态背影图片
 */
-(void)setNormalBg:(NSString *)normalBg{
    
    [self setBackgroundImage:[UIImage imageNamed:normalBg] forState:UIControlStateNormal];
}
-(void)setNBg:(NSString *)nBg{
    [self setBackgroundImage:[UIImage imageNamed:nBg] forState:UIControlStateNormal];
}

/**
 *  设置未拉伸的高亮状态背影图片
 */
-(void)setHighlightedBg:(NSString *)highlightedBg{
    [self setBackgroundImage:[UIImage imageNamed:highlightedBg] forState:UIControlStateHighlighted];
}
-(void)setHBg:(NSString *)hBg{
    [self setBackgroundImage:[UIImage imageNamed:hBg] forState:UIControlStateHighlighted];
}
/**
 *  设置未拉伸后的正常和高亮状态按钮背影图片
 *
 *  @param normalBg    普通状态的背影图片
 *  @param highlighted 高亮状态的背影图片
 */
-(void)setNormalBg:(NSString *)normalBg highlightedBg:(NSString *)highlightedBg{
    [self setNormalBg:normalBg];
    [self setHighlightedBg:highlightedBg];
}
-(void)setNBg:(NSString *)nBg hBg:(NSString *)hBg{
    [self setNBg:nBg];
    [self setHBg:hBg];
}

-(void)setNormalImage:(NSString *)normal highlightedImage:(NSString *)highlighted{
    [self setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:highlighted] forState:UIControlStateHighlighted];
}



@end
