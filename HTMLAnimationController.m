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

-(id)initWithHtmlFileName:(NSString *)fileName{
    if ([super init]) {
        NSString *filePath1 = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
        NSString *htmlString1 = [NSString stringWithContentsOfFile:filePath1 encoding:NSUTF8StringEncoding error:nil];
        htmlString = htmlString1;
        filePath = filePath1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"HTML Demo 展示";
    
    //关闭按钮
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_navigation_close"] style:UIBarButtonItemStyleDone target:self action:@selector(backToVC)];
    self.navigationItem.leftBarButtonItem = item;
    //添加webview
    [self addWebView];
    
}
#pragma mark 返回
- (void)backToVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 加载webView
-(void)addWebView{
    localWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    localWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight ;
    localWebView.delegate = self;
    localWebView.scalesPageToFit = YES;
    localWebView.backgroundColor = [UIColor clearColor];
    localWebView.opaque = YES;
    
    
//    // Hide the images that make the shadows
//    for(UIView *innerView in [[[localWebView subviews] objectAtIndex:0] subviews]) {
//        if([innerView isKindOfClass:[UIImageView class]]) { innerView.hidden = YES; }
//    }
//    
    [self.view addSubview:localWebView];
    
    [localWebView loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
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
