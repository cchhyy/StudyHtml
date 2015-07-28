//
//  ImageModel.m
//  UI_21_collectionView
//
//  Created by ccyy on 15/6/10.
//  Copyright (c) 2015年 111. All rights reserved.
//

#import "ImageModel.h"

@implementation ImageModel
/**
 *  处理有时候返回数据和model类属性不对应，找不到具体的key而发生的崩溃
 *
 *  @param value <#value description#>
 *  @param key   <#key description#>
 */
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"key = %@",key);
}

@end
