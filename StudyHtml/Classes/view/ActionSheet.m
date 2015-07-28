//
//  ActionSheet.m
//  StudyHtml
//
//  Created by ccyy on 15/7/24.
//  Copyright (c) 2015年 ccyy. All rights reserved.
//

#import "ActionSheet.h"
#import "SettingViewController.h"

@interface ActionSheet ()

@end

@implementation ActionSheet


-(void)addActionsActionByController:(UIViewController *)controller
{
//    if ([super init]) {
    UIAlertAction *sheet0 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
        
        UIAlertAction *sheet1 = [UIAlertAction actionWithTitle:@"应用介绍" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self  controller:controller  presentSettingViewControllerWithText:@"本应用提供给喜欢学习的你，可以学习HTML的基础知识，可以查询前端工程师的大概薪资，可以观看一些简单的Demo，还可以收看到定期更新的热门行业资讯，希望您喜欢"];
        }];
        
        UIAlertAction *sheet2 = [UIAlertAction actionWithTitle:@"关于" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self   controller:controller presentSettingViewControllerWithText:@"本App数据均来源于互联网，学习资料部分经过个人修改制作。如有侵权，请联系我，会尽快进行处理"];
        }];
        
        UIAlertAction *sheet3 = [UIAlertAction actionWithTitle:@"联系方式" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self  controller:controller presentSettingViewControllerWithText:@"联系方式：chenhuaizhe@gmail.com"];
            
        }];
    
        [self addAction:sheet1];
        [self addAction:sheet2];
        [self addAction:sheet3];
        [self addAction:sheet0];
    
    
    UIPopoverPresentationController *pop = self.popoverPresentationController;
    //            pop.delegate = self;
    pop.sourceView = controller.view;
    pop.permittedArrowDirections = UIPopoverArrowDirectionDown;
//    pop.barButtonItem = 
    // 显示位置
   pop.sourceRect = CGRectMake((CGRectGetWidth(pop.sourceView.bounds)-2)*0.09f, (CGRectGetHeight(pop.sourceView.bounds)-2)*0.82f, 0, 0);
    [controller presentViewController:self animated:YES completion:nil];
}


-(void)controller:(UIViewController *)controller   presentSettingViewControllerWithText:(NSString *)text{
    SettingViewController *svc = [[SettingViewController alloc]init];
    svc.modalTransitionStyle =  UIModalTransitionStyleCrossDissolve;
    svc.modalPresentationStyle = UIModalPresentationFormSheet;
    [controller  presentViewController:svc animated:YES completion:nil];
    svc.preferredContentSize = CGSizeMake(320, 350);
    svc.setingLabel.text = text;
}

//*********************************************************************************************

-(void)addScoreAppByController:(UIViewController *)controller
{
    UIAlertAction *sheet0 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIAlertAction *sheet1 = [UIAlertAction actionWithTitle:@"去AppStore给我们好评" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
       [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/html-ru-men/id1020932687?mt=8"]];
    }];
    
    UIAlertAction *sheet2 = [UIAlertAction actionWithTitle:@"意见反馈" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto://chenhuaizhe@gmail.com"]];
    }];
    
    
    [self addAction:sheet1];
    [self addAction:sheet2];
    [self addAction:sheet0];
    
    
    UIPopoverPresentationController *pop = self.popoverPresentationController;
    //            pop.delegate = self;
    pop.sourceView = controller.view;
    pop.permittedArrowDirections = UIPopoverArrowDirectionDown;
    //    pop.barButtonItem =
    // 显示位置
    pop.sourceRect = CGRectMake((CGRectGetWidth(pop.sourceView.bounds)-2)*0.2f, (CGRectGetHeight(pop.sourceView.bounds)-2)*0.92f, 0, 0);
    [controller presentViewController:self animated:YES completion:nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
