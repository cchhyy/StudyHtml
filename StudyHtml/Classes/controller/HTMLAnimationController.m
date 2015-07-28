//
//  HTMLAnimationController.m
//  StudyHtml
//
//  Created by ccyy on 15/7/18.
//  Copyright (c) 2015年 ccyy. All rights reserved.
//

#import "HTMLAnimationController.h"
#import "CommonDefine.h"
@interface HTMLAnimationController () <UIWebViewDelegate>
{
    
    NSString * htmlString;
    NSString *filePath;
    
}

@end

@implementation HTMLAnimationController
@synthesize localWebView;

//利用本地文件初始化
-(id)initWithHtmlFileName:(NSString *)fileName{
    if ([super init]) {
        NSString *filePath1 = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
        NSString *htmlString1 = [NSString stringWithContentsOfFile:filePath1 encoding:NSUTF8StringEncoding error:nil];
        htmlString = htmlString1;
        filePath = filePath1;
        //添加webview
        [self addWebView];
         [localWebView loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
    }
    return self;
}

//网络初始化
//-(instancetype) initWithUrlString:(NSString *)urlString{
//    if ([super init]) {
//        NSURL *url = [NSURL URLWithString:urlString];
//        NSURLRequest *request = [NSURLRequest requestWithURL:url];
//        [self addWebView];
//        [localWebView loadRequest:request];
//    }
//    return  self;
//}
-(void)loadView{
    [super loadView];
    //加载网络数据
    if (self.url) {
        NSURL *url = [NSURL URLWithString:self.url];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self addWebView];
        [localWebView loadRequest:request];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"HTML Demo 展示";
    
    //关闭按钮
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_navigation_close"] style:UIBarButtonItemStyleDone target:self action:@selector(backToVC)];
    self.navigationItem.leftBarButtonItem = item;
    

}
#pragma mark 返回
- (void)backToVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 加载webView
-(void)addWebView{
    localWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height)];
    localWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight ;
    localWebView.delegate = self;
    localWebView.scalesPageToFit = YES;
   localWebView.backgroundColor = [UIColor clearColor];
    localWebView.opaque = YES;

    [self.view addSubview:localWebView];
    
}

#pragma mark webView代理方法
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    // Starting the load, show the activity indicator in the status bar
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    // Finished loading, hide the activity indicator in the status bar
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    // Load error, hide the activity indicator in the status bar
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error Loading Page", nil)
                                                         message:[error localizedDescription]
                                                        delegate:nil
                                               cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                               otherButtonTitles:nil];
    
    [alertView show];
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)viewDidUnload {
    
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    self.localWebView = nil;
    
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
