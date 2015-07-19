//
//  SecondViewController.m
//  StudyHtml
//
//  Created by ccyy on 15/7/16.
//  Copyright (c) 2015年 ccyy. All rights reserved.
//

#import "SecondPopViewController.h"
#import "ChangeCityViewController.h"
#import "MyNavController.h"

@interface SecondPopViewController ()
@end

@implementation SecondPopViewController
- (IBAction)changeCityBtnClick:(UIButton *)sender {
    //模态出一个城市选择页面
    ChangeCityViewController *cvc = [[ChangeCityViewController alloc]initWithNibName:@"ChangeCityViewController" bundle:nil];
   MyNavController *nav = [[MyNavController alloc]initWithRootViewController:cvc];
  nav.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:nav animated:YES completion:nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.cityNameLabel.text = @"当前城市：广州";
    NSInteger m = arc4random()%250000 + 60000;
    self.yearMoneyLabel.text = [NSString stringWithFormat:@"年度薪酬约：%ld元",(long)m];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationCityNameChanged:) name:@"cityNameChanged" object:nil];

}

-(void)notificationCityNameChanged:(NSNotification *)notification{
    NSDictionary *dic = notification.userInfo;
    self.cityNameLabel.text = dic[@"cityName"];
    NSLog(@"cityName = %@",self.cityNameLabel.text);
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
