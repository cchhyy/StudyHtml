//
//  LearnViewController.m
//  StudyHtml
//
//  Created by ccyy on 15/7/18.
//  Copyright (c) 2015年 ccyy. All rights reserved.
//

#import "LearnViewController.h"
#import <WebKit/WebKit.h>
#import "SearchViewController.h"

@interface LearnViewController ( )
@property (nonatomic,strong ) WKWebView *webView;

@end

@implementation LearnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.lesssonName;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //关闭按钮
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_navigation_close"] style:UIBarButtonItemStyleDone target:self action:@selector(backToVC)];
    self.navigationItem.leftBarButtonItem = item;
    
    [self addWKWebView];
    

    
}

- (void)backToVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) addWKWebView{
#warning 这里需要在添加了更多html资料之后进行修改
    if (!([self.lesssonName hasPrefix:@"HTML"]   || [self.lesssonName hasPrefix:@"CSS"]  || [self.lesssonName hasPrefix:@"js"]   || [self.lesssonName hasPrefix:@"json"])) {
        self.lesssonName = @"数据结构";
    }
    NSInteger a = self.navigationController.viewControllers.count;
    if (a == 2) {
                self.webView  = [[WKWebView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width-200, self.view.frame.size.height-440)];
    }else{
           self.webView  = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    }

    [self.view addSubview:self.webView];
  
    NSString *fileName = [NSString stringWithFormat:@"%@.html",self.lesssonName];
    NSString *filePath = [[NSBundle mainBundle ] pathForResource:fileName ofType:nil];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
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
