//
//  AddBarButtons.h
//  StudyHtml
//
//  Created by ccyy on 15/7/26.
//  Copyright (c) 2015年 ccyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class NavItem,FirstViewController;
@interface AddBarButtons : NSObject

//向FirstViewController上添加导航栏按钮
-(void) addBarButtonsInController:(UIViewController *)controller;

//导航栏左边BarButtonItem触发的事件
-(void)clickInController:(FirstViewController *)controller;

//导航栏搜索
-(void)searchLesson:(UIBarButtonItem *)searchBarBtnItem;

//音乐
-(void)playMusicInController:(UIViewController *)controller;

@end
