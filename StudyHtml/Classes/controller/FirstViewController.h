//
//  FirstViewController.h
//  StudyHtml
//
//  Created by ccyy on 15/7/16.
//  Copyright (c) 2015年 ccyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UICollectionViewController

@property (nonatomic,strong) NSString *newsUrl;

@property (nonatomic,assign ) NSInteger navItemIndex;//当前的navItem的序号
@end
