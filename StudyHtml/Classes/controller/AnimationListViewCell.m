//
//  AnimationListViewCell.m
//  StudyHtml
//
//  Created by ccyy on 15/7/18.
//  Copyright (c) 2015年 ccyy. All rights reserved.
//

#import "AnimationListViewCell.h"

@implementation AnimationListViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 280, 50)];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRed:50/255.0 green:180/255.0 blue:170/255.0 alpha:1.0];
        self.listLabel.alpha = 0.65;
        self.listLabel = label;
        self.listLabel.font = [UIFont systemFontOfSize:20.0];
        self.listLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.listLabel];
    }
    return self;
}

@end
