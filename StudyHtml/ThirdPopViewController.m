//
//  ThirdPopViewController.m
//  StudyHtml
//
//  Created by ccyy on 15/7/18.
//  Copyright (c) 2015年 ccyy. All rights reserved.
//

#import "ThirdPopViewController.h"
#import "AnimationListView.h"
#import "AnimationListViewCell.h"
#import "HTMLAnimationController.h"
#import "MyNavController.h"

@interface ThirdPopViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong) AnimationListView *animationListView;

@end

@implementation ThirdPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.preferredContentSize = CGSizeMake(180, 250);
    [self addAnimationView];
    
}

-(void)addAnimationView{
    AnimationListView *ani = [[AnimationListView alloc]init];
    self.animationListView = ani;
    [self.view addSubview:self.animationListView];
    self.animationListView.delegate = self;
    self.animationListView.dataSource = self;
}



#pragma mark 代理方法
-(NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AnimationListViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"listCell" forIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:
            cell.listLabel.text = @"旋转的风车";
            break;
        case 1:
            cell.listLabel.text = @"从天而降的蛋糕";
            break;
        case 2:
            cell.listLabel.text = @"3D轮播相册";
            break;
        case 3:
            cell.listLabel.text = @"活动指示器动画";
            break;
        default:
            break;
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *fileName = [NSString stringWithFormat:@"animation%ld.html",(long)indexPath.row];
//    NSLog(@"fileName = %@",fileName);
    HTMLAnimationController *hvc = [[HTMLAnimationController alloc]initWithHtmlFileName:fileName];
    MyNavController *nav = [[MyNavController alloc]initWithRootViewController:hvc];
    nav.modalPresentationStyle =  UIModalPresentationFormSheet;
    [self presentViewController:nav animated:YES completion:nil];
    
}











- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
