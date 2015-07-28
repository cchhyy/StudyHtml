//
//  HTMLAnimationController.h
//  StudyHtml
//
//  Created by ccyy on 15/7/18.
//  Copyright (c) 2015年 ccyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTMLAnimationController : UIViewController
@property (nonatomic, strong) UIWebView * localWebView;
@property (nonatomic,retain) NSString *url;

- (id)initWithHtmlFileName:(NSString *)fileName;
//-(instancetype) initWithUrlString:(NSString *)urlString;


@end
