//
//  ChangeCityViewController.m
//  StudyHtml
//
//  Created by ccyy on 15/7/16.
//  Copyright (c) 2015年 ccyy. All rights reserved.
//

#import "ChangeCityViewController.h"
#import "MJExtension.h"
#import "CityGroupsModel.h"
#import "SearchCityResultViewController.h"
#import "UIView+AutoLayout.h"

@interface ChangeCityViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIView *coverView;
@property (strong,nonatomic) NSMutableArray *cityArray;
@property (strong,nonatomic) SearchCityResultViewController *searchVC;

@end

@implementation ChangeCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"切换城市";
    
    //关闭按钮
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_navigation_close"] style:UIBarButtonItemStyleDone target:self action:@selector(backToVC)];
    self.navigationItem.leftBarButtonItem = item;

}

- (void)backToVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}



-(NSMutableArray *)cityArray{
    if (_cityArray == nil ) {
        _cityArray = [ CityGroupsModel objectArrayWithFilename:@"cityGroups.plist"];
    }
    return _cityArray;
}


#pragma mark tableview代理方法
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    CityGroupsModel *city  = self.cityArray[section];
    return city.cities.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    CityGroupsModel *city = self.cityArray[indexPath.section] ;
    cell.textLabel.text = city.cities[indexPath.row];
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cityArray.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    CityGroupsModel *city = self.cityArray[section];
    return city.title;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CityGroupsModel *city = self.cityArray[indexPath.section];
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cityNameChanged" object:nil userInfo:@{@"cityName":city.cities[indexPath.row]}];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
#pragma mark searchBar的代理方法
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    self.coverView.hidden = NO;
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];

    }
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length) {
        self.searchVC.view.hidden = NO;
    }
    else{
        self.searchVC.view.hidden = YES;
        
    }
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    self.coverView.hidden = YES;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


#pragma mark searchVC懒加载
-(SearchCityResultViewController *)searchVC{
    if (_searchVC == nil) {
        _searchVC = [[SearchCityResultViewController alloc]init];
        [self.view addSubview:_searchVC.view];
        //添加约束 设置搜索结果控制器的尺寸位置
        [self.searchVC.view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        //让searchResultVC的顶部 贴着搜索框的底部  不遮盖住搜索框
        [self.searchVC.view autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.searchBar];
        
    }
    return _searchVC;
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
