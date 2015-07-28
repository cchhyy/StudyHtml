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
        self.listLabel.alpha = 0.65;
        self.listLabel = label;
        self.listLabel.font = [UIFont systemFontOfSize:25.0];
        self.listLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.listLabel];
    }
    return self;
}

@end
