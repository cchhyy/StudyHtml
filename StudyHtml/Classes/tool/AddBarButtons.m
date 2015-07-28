//
//  AddBarButtons.m
//  StudyHtml
//
//  Created by ccyy on 15/7/26.
//  Copyright (c) 2015年 ccyy. All rights reserved.
//

#import "AddBarButtons.h"
#import "NavItem.h"
#import "UIButton+CCYY.h"
#import "SearchViewController.h"
#import "MyNavController.h"
#import "MusicViewController.h"
#import "FirstPopViewController.h"
#import "SecondPopViewController.h"
#import "ThirdPopViewController.h"
#import "FirstViewController.h"
@interface AddBarButtons ()
{
    UIBarButtonItem *_firstItem;
    UIBarButtonItem *_secondItem;
    UIBarButtonItem *_thirdItem;
    UIPopoverPresentationController *_pop1;
    UIPopoverPresentationController *_pop2;
    UIPopoverPresentationController *_pop3;
    UIButton *_musicButton;
    UIImageView *imgV;
    
}
@end

@implementation AddBarButtons

#pragma mark 添加导航栏按钮
-(void)addBarButtonsInController:(UIViewController *)controller
{
    //添加导航栏左边的按钮
    UIImage *logoImage=[UIImage imageNamed: @"logo.png"];
    logoImage = [logoImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *logoBarBtnItem = [[UIBarButtonItem alloc]initWithImage:logoImage style:UIBarButtonItemStyleDone target:nil  action:nil];
    
    NavItem *first = [NavItem makeItem];
    NavItem *second = [NavItem makeItem];
    NavItem *third = [NavItem makeItem];
    //如果是iphone手机
    if ([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        CGRect rect = CGRectMake(0, 0, 35, 35);
        first.frame = rect;
        second.frame = rect;
        third.frame = rect;
    }else{
        first.smallLabel.text = @"学习";
        first.bigLabel.text = @"简单教程";
        second.smallLabel.text = @"查询";
        second.bigLabel.text = @"薪资水平";
        third.smallLabel.text = @"演示";
        third.bigLabel.text = @"经典Demo";
    }
    
    [second.button setNormalImage:@"iconfont-gongzi" highlightedImage:@"iconfont-gongzi_s"];
    [third.button setNormalImage:@"iconfont-zuopinzhanshi" highlightedImage:@"iconfont-zuopinzhanshi_s"];
    
    [first addTarget:controller  action:@selector(firstClick:)];
    [second addTarget:controller action:@selector(secondClick:)];
    [third addTarget:controller action:@selector(thirdClick:)];
    
    _firstItem = [[UIBarButtonItem alloc]initWithCustomView:first];
    _secondItem = [[UIBarButtonItem alloc]initWithCustomView:second];
    _thirdItem = [[UIBarButtonItem alloc]initWithCustomView:third];
    
    controller.navigationItem.leftBarButtonItems = @[logoBarBtnItem,_firstItem,_secondItem,_thirdItem];
    
    //添加导航栏右边的按钮
    UIImage *searchImage = [UIImage imageNamed:@"icon_search"];
    searchImage = [searchImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *searchBarItem = [[UIBarButtonItem alloc]initWithImage:searchImage  style:UIBarButtonItemStyleDone target:controller action:@selector(searchLesson:)];
    
    _musicButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _musicButton.frame = CGRectMake(0, 0, 30, 30);
    [_musicButton setNBg:@"iconfont-yinle" hBg:@"iconfont-yinle_s"];
    [_musicButton addTarget:controller action:@selector(playMusic:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *circleBar = [[UIBarButtonItem alloc]initWithCustomView:_musicButton];
    controller.navigationItem.rightBarButtonItems = @[searchBarItem,circleBar];
    
//#pragma mark 定时器
//    CADisplayLink  *link = [CADisplayLink displayLinkWithTarget:controller selector:@selector(update)];
//    [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];

}

//==============================
-(void)firstClick:(NavItem *)navItem{
    NSLog(@"popClick In AddBarItems");
}
-(void)secondClick:(NavItem *)navItem{
    NSLog(@"popClick In AddBarItems");
}
-(void)thirdClick:(NavItem *)navItem{
    NSLog(@"popClick In AddBarItems");
}
-(void)playMusic:(UIButton *)btn{}
//==============================


#pragma mark 搜索
-(void)searchLesson:(UIBarButtonItem *)searchBarBtnItem{
    if (_pop1 ) {
        [_pop1.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    }
    if (_pop2 ) {
        [_pop2.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    }
    if (_pop3) {
        [_pop3.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    }

    SearchViewController *svc = [[SearchViewController alloc]init];
    MyNavController *nav = [[MyNavController alloc]initWithRootViewController:svc];
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    [searchBarBtnItem.target  presentViewController:nav animated:YES completion:nil];
}

#pragma mark 点击左边的下拉菜单执行的方法
-(void)clickInController:(FirstViewController *)controller
{
    if (controller.navItemIndex ==1) {
        if (_pop2 ) {
            [_pop2.presentedViewController dismissViewControllerAnimated:YES completion:nil];
        }
        if (_pop3) {
            [_pop3.presentedViewController dismissViewControllerAnimated:YES completion:nil];
        }
        
        FirstPopViewController *pVc = [[FirstPopViewController alloc]init];
        pVc.modalPresentationStyle = UIModalPresentationPopover;
        _pop1 = pVc.popoverPresentationController;
        _pop1.barButtonItem = _firstItem;
        //如果是ipad手机
        if ([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            [controller presentViewController:pVc animated:YES completion:nil];
        }else{
            [controller.navigationController pushViewController:pVc animated:YES];
            
        }
    }else  if (controller.navItemIndex ==2) {
        if (_pop1 ) {
            [_pop1.presentedViewController dismissViewControllerAnimated:YES completion:nil];
        }
        if (_pop3) {
            [_pop3.presentedViewController dismissViewControllerAnimated:YES completion:nil];
        }
            SecondPopViewController *svc = [[SecondPopViewController alloc]initWithNibName:@"SecondPopViewController" bundle:nil];;
            svc.modalPresentationStyle = UIModalPresentationPopover;
            _pop2 = svc.popoverPresentationController;
            _pop2.barButtonItem = _secondItem;
            //如果是ipad手机
            if ([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                [controller presentViewController:svc animated:YES completion:nil];
            }else{
                [controller.navigationController pushViewController:svc animated:YES];
                
            }
    }else   if (controller.navItemIndex ==3) {
        if (_pop2 ) {
            [_pop2.presentedViewController dismissViewControllerAnimated:YES completion:nil];
        }
        if (_pop1) {
            [_pop1.presentedViewController dismissViewControllerAnimated:YES completion:nil];
        }
        
 ThirdPopViewController *tvc = [[ThirdPopViewController alloc]init];
        tvc.modalPresentationStyle = UIModalPresentationPopover;
        _pop3 = tvc.popoverPresentationController;
        _pop3.barButtonItem = _thirdItem;
        //如果是ipad手机
        if ([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            [controller presentViewController:tvc animated:YES completion:nil];
        }else{
            [controller.navigationController pushViewController:tvc animated:YES];
            
        }
    }
}



-(void)playMusicInController:(UIViewController *)controller
{
    MusicViewController *musicVC = [MusicViewController shareMusicController];
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
    
        musicVC.modalPresentationStyle = UIModalPresentationFormSheet;
        musicVC.preferredContentSize = CGSizeMake(150, 50);
        [controller presentViewController:musicVC animated:NO completion:nil];
    }else{
        [musicVC playMusic];
        [musicVC play:nil];
    }

}








@end
