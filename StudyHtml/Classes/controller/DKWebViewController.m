//
//  DKWebViewController.m
//  DiscoKit
//
//  Created by Keith Pitt on 5/04/11.
//  Copyright 2011 DiscoKit. All rights reserved.
//

#import "DKWebViewController.h"
#import "CommonDefine.h"
#import "UIButton+CCYY.h"
#import "News.h"
#import "SQLiteManager.h"
@interface DKWebViewController ()<UIAlertViewDelegate>
{
    
        UIAlertView *_alert;
    UIButton *_collectedButton;
    NSTimer *_timer;
}

@property (nonatomic,assign) BOOL hasCollected; //是否已经收藏了

@end

@implementation DKWebViewController



@synthesize localWebView;

- (id)initWithStringURL:(NSString *)baseURL {
    
    if ((self = [super init])) {
        _url = baseURL;
    }
    
	return self;
    
}

- (void)viewDidLoad {
	
	[super viewDidLoad];
    
    self.title = self.newsTitle;
	
    //从数据库判断是否已经收藏
    self.hasCollected = [self isCollected];
    NSLog(@"是否收藏：%d",self.hasCollected);
        localWebView = [[UIWebView alloc] initWithFrame:CGRectMake(-10, -238, ScreenWidth+255, ScreenHeight+220)];
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        localWebView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    }
    localWebView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    localWebView.delegate = self;
	localWebView.scalesPageToFit = true;
    localWebView.backgroundColor = [UIColor clearColor];
    localWebView.opaque = NO;
	[self.view addSubview:localWebView];
	[self.localWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    
    
    //添加收藏按钮
    _collectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _collectedButton.frame = CGRectMake(0, 0, 30, 30);
    if (self.hasCollected) {
        [_collectedButton setNBg:@"icon_pathMenu_collect_highlighted"];
    }else{
        [_collectedButton setNBg:@"icon_orderReview_rating_star_not_picked"];
    }
    [_collectedButton   addTarget:self action:@selector(collectedBUttonClick: ) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *collect = [[UIBarButtonItem alloc]initWithCustomView:_collectedButton];
    self.navigationItem.rightBarButtonItem = collect;
	
    //关闭按钮
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_navigation_close"] style:UIBarButtonItemStyleDone target:self action:@selector(backToVC)];
    self.navigationItem.leftBarButtonItem = item;
    
}

- (void)backToVC{
    [self.navigationController popViewControllerAnimated:YES];
}


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

#pragma mark 从数据库中看是否已经存在该news
-(BOOL) isCollected{
    NSLog(@"self.newsTitle = %@",self.newsTitle);
        News *news =  [SQLiteManager findNewsByTitle:self.newsTitle];
    NSLog(@"查询到的news ＝ %@",news);
    if (news.title) {
        return YES;
    }else{
        return NO;
    }
}




//收藏(本地数据库)
-(void)collectedBUttonClick:(UIButton *) btn
{
    if (!self.hasCollected) {
        self.hasCollected = YES;
        News *news = [[News alloc]init];
        news.title = self.newsTitle;
        news.url = self.url;
        [SQLiteManager addNews:news];
        //修改button的背景图片
        [_collectedButton setNBg:@"icon_pathMenu_collect_highlighted"];
    }else{
        [self alertShow];
    }
}

#warning 设置一个自动消失的alertview可以写成一个类目
-(void)alertShow{
    _alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"亲，已经收藏过了哦" delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
  [_alert show];
   _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(doTime) userInfo:nil repeats:NO];
//    [_timer fire];
    
}

//alert过1秒自动消失
-(void)doTime
{
    [_alert dismissWithClickedButtonIndex:0 animated:YES];
//    [_timer invalidate];
}



@end
