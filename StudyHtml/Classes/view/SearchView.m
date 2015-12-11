//
//  SearchView.m
//  StudyHtml
//
//  Created by ccyy on 15/7/18.
//  Copyright (c) 2015年 ccyy. All rights reserved.
//

#import "SearchView.h"

@implementation SearchView

+(instancetype)makeSearchView{
    return [[[NSBundle mainBundle]loadNibNamed:@"SearchView" owner:self options:nil]firstObject];
}

@end
