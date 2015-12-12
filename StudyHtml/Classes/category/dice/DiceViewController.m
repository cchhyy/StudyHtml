//
//  ViewController.m
//  Dice
//
//  Created by Damien Laughton on 30/10/2014.
//  Copyright (c) 2014 Damien Laughton. All rights reserved.
//

#import "DiceViewController.h"
#import "DiceTableViewCell.h"
#import "SQLiteManager.h"
#import "News.h"
#import "DKWebViewController.h"
#import "MyNavController.h"


@interface DiceViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic) CGPoint lastContentOffset;
@property (strong,nonatomic) NSArray *newsArray;

@end

@implementation DiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"收藏";
    // Do any additional setup after loading the view, typically from a nib.
#pragma mark 获取数据
    self.newsArray =  [SQLiteManager findAllNews];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DiceTableViewCell" bundle:nil] forCellReuseIdentifier:@"DiceTableViewCell"];
    
    //关闭按钮
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_navigation_close"] style:UIBarButtonItemStyleDone target:self action:@selector(backToVC)];
    self.navigationItem.leftBarButtonItem = item;
    
}

- (void)backToVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    CGFloat heightForRowAtIndexPath = 160.0f;
    
    return heightForRowAtIndexPath;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    NSInteger numberOfRowsInSection = self.newsArray.count;
    
    return numberOfRowsInSection;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    DiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DiceTableViewCell" forIndexPath:indexPath];
    
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg", (long)indexPath.row%8+1]];
    
    cell.imageViewBackground.image = image;
    News *news= self.newsArray[indexPath.row];
    cell.titleLabel.text = news.title;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    News *news= self.newsArray[indexPath.row];
    DKWebViewController *dvc = [[DKWebViewController alloc]initWithStringURL:news.url];
//    MyNavController *nav = [[MyNavController alloc]initWithRootViewController:dvc];
    dvc.url = news.url;
    dvc.newsTitle = news.title;
    [self.navigationController pushViewController:dvc animated:YES];
    
}




- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    DiceTableViewCellScrollDirection scrollDirection = ScrollDirectionNone;
    
    if (self.lastContentOffset.x > scrollView.contentOffset.x)
    {
        scrollDirection = ScrollDirectionRight;
    }
    else if (self.lastContentOffset.x < scrollView.contentOffset.x)
    {
        scrollDirection = ScrollDirectionLeft;
    }
    else if (self.lastContentOffset.y > scrollView.contentOffset.y)
    {
        scrollDirection = ScrollDirectionDown;
//        NSLog(@"DOWN");
    }
    else if (self.lastContentOffset.y < scrollView.contentOffset.y)
    {
        scrollDirection = ScrollDirectionUp;
//        NSLog(@"UP");
    }
    else
    {
        scrollDirection = ScrollDirectionCrazy;
    }
    
    self.lastContentOffset = scrollView.contentOffset;
    
    id notificationObject = [NSNumber numberWithInteger:scrollDirection];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:DiceTableViewCellDirectionNotification object:notificationObject];


}

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
