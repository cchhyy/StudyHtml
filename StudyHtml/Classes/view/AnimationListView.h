//
//  AnimationListView.h
//  StudyHtml
//
//  Created by ccyy on 15/7/18.
//  Copyright (c) 2015年 ccyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationListView : UICollectionView

//刷新
-(void)addFooterRefreshWithTarget:( id)target action:( SEL) action;

//停止刷新
-(void)stopFooterRefresh;





@end
