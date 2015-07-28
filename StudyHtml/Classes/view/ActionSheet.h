//
//  ActionSheet.h
//  StudyHtml
//
//  Created by ccyy on 15/7/24.
//  Copyright (c) 2015年 ccyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActionSheet : UIAlertController

-(void)addActionsActionByController:(UIViewController *)controller;

-(void)addScoreAppByController:(UIViewController *)controller;

@end
