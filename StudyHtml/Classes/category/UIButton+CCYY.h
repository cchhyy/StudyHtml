//
//  UIButton+CCYY.h
//  StudyHtml
//
//  Created by ccyy on 15/7/17.
//  Copyright (c) 2015年 ccyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CCYY)
/**
 *  设置未拉伸的正常状态背影图片
 */
-(void)setNormalBg:(NSString *)normalBg;
-(void)setNBg:(NSString *)nBg;


/**
 *  设置未拉伸后的正常和高亮状态按钮背影图片
 *
 *  @param normalBg    普通状态的背影图片
 *  @param highlighted 高亮状态的背影图片
 */
-(void)setNormalBg:(NSString *)normalBg highlightedBg:(NSString *)highlightedBg;
-(void)setNBg:(NSString *)nBg hBg:(NSString *)hBg;

//设置普通image和高亮的image
-(void)setNormalImage:(NSString *)normal highlightedImage:(NSString *)highlighted;
@end
