//
//  AnimationListView.m
//  StudyHtml
//
//  Created by ccyy on 15/7/18.
//  Copyright (c) 2015年 ccyy. All rights reserved.
//

#import "AnimationListView.h"
#import "CommonDefine.h"
#import "AnimationListViewCell.h"
#import "MJRefresh.h"

@implementation AnimationListView

-(instancetype)init{
    
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        
        flowLayout.itemSize = CGSizeMake(300-10, 60);
        //    //设置最小列间距
        //    flowLayout.minimumInteritemSpacing = 20;
        //最小行间距
        flowLayout.minimumLineSpacing = 5;
        //滚动方向
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //外部边距(上左下右）
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        self = [[AnimationListView alloc]initWithFrame:CGRectMake(0, 0, 300, 500) collectionViewLayout:flowLayout];
        self.backgroundColor = [UIColor whiteColor];
    
        [self registerClass:[AnimationListViewCell class] forCellWithReuseIdentifier:@"listCell"];
    
    
    
    return self;
}

-(void)addFooterRefreshWithTarget:(id)target action:(SEL)action
{

    [self addLegendFooterWithRefreshingTarget:target refreshingAction:action];

}

-(void)stopFooterRefresh{
    if ([self.footer isRefreshing]) {
        [self.footer endRefreshing];
    }
}





@end
