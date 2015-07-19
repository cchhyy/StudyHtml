//
//  NavItem.m
//  StudyHtml
//
//  Created by ccyy on 15/7/16.
//  Copyright (c) 2015年 ccyy. All rights reserved.
//

#import "NavItem.h"

@implementation NavItem

+(instancetype)makeItem
{
    return [[[NSBundle mainBundle] loadNibNamed:@"NavItem" owner:self options:nil] firstObject];
}

-(void)addTarget:(id)target action:(SEL)action
{
    [self.button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}
@end
