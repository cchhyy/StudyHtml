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
@property (weak, nonatomic) IBOutlet UIView *companyView;
@property (weak, nonatomic) IBOutlet UIButton *comanyType;
@property (nonatomic,assign) NSInteger cityPart;
@property (nonatomic,assign) NSInteger companyPart;

@end

//typedef enum {
//  @"欧美外资" ,
//    @"非欧美外资",
//    @"欧美合资",
//    @"非欧美合资",
//    @"国企／上市企业",
//    @"民营／私营公司",
//    @"欧美外资合资"
//}CompanyName;

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

    //从本地读取当前城市名称
  NSString *name =  [[NSUserDefaults standardUserDefaults] objectForKey:@"cityName"];
    if (name) {
        self.cityNameLabel.text = name;
    }else{
        self.cityNameLabel.text = @"广州";
    }
    self.companyPart = 100000;
    
    [self refreshMoney];
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationCityNameChanged:) name:@"cityNameChanged" object:nil];

    [self circleTheView:self.companyView withCornerRadius:30];
    [self circleTheView:self.comanyType withCornerRadius:8];
}
//选择城市之后收到的通知
-(void)notificationCityNameChanged:(NSNotification *)notification{
    NSDictionary *dic = notification.userInfo;
    self.cityNameLabel.text = dic[@"cityName"];
    NSLog(@"cityName = %@",self.cityNameLabel.text);
    //刷新年薪
    [self refreshMoney];
    //保存城市名称到本地
    [[NSUserDefaults standardUserDefaults]setObject:self.cityNameLabel.text forKey:@"cityName"];
}

- (IBAction)toChooseCompany:(id)sender {
    self.companyView.hidden = NO;
}

//在companyView上点击后选择对应的公司
- (IBAction)changeCompanyType:(UIButton *)sender {
    [self.comanyType setTitle:sender.titleLabel.text forState:UIControlStateNormal];
    self.companyView.hidden = YES;
    if ([sender.titleLabel.text isEqualToString: @"欧美外资"] ) {
        self.companyPart = 160000;
    }else    if ([sender.titleLabel.text isEqualToString: @"非欧美外资"] ) {
        self.companyPart = 124000;
    }else     if ([sender.titleLabel.text isEqualToString: @"欧美合资"] ) {
        self.companyPart = 140000;
    }else     if ([sender.titleLabel.text isEqualToString: @"非欧美合资"] ) {
        self.companyPart = 110000;
    }else      if ([sender.titleLabel.text isEqualToString: @"国企／上市企业"] ) {
        self.companyPart = 130000;
    }else      if ([sender.titleLabel.text isEqualToString: @"民营／私营公司"] ) {
        self.companyPart = 100000;
    }else   {
        self.companyPart = 150000;
    }
    [self refreshMoney];

}

-(void)circleTheView:(UIView *)view withCornerRadius:(NSInteger) cornerRadius
{
    view.layer.cornerRadius = cornerRadius;
    view.layer.masksToBounds = YES;
}

-(void)refreshMoney
{
    if ([self.cityNameLabel.text isEqualToString:@"北京" ] ||  [self.cityNameLabel.text isEqualToString:@"上海" ] || [self.cityNameLabel.text isEqualToString:@"广州" ] || [self.cityNameLabel.text isEqualToString:@"深圳" ] || [self.cityNameLabel.text isEqualToString:@"杭州" ] || [self.cityNameLabel.text isEqualToString:@"成都" ] || [self.cityNameLabel.text isEqualToString:@"西安" ] ) {
        self.cityPart = 120000;
    }else{
        self.cityPart = arc4random()%50000+30000;
    }
    NSInteger m = arc4random()%1000 ;
    NSInteger n = self.companyPart*0.5 + self.cityPart *0.5 + m;
    self.moneyLabel.text = [NSString stringWithFormat:@"%ld元",(long)n];
    NSLog(@"n = %ld",(long)n);
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
