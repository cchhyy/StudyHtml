//
//  SearchViewController.m
//  StudyHtml
//
//  Created by ccyy on 15/7/18.
//  Copyright (c) 2015年 ccyy. All rights reserved.
//

#import "SearchViewController.h"
#import "MyNavController.h"
#import "LearnViewController.h"

@interface SearchViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *lessonArray;
@property (strong,nonatomic) NSMutableArray *resultArray;


@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜索";
    self.view.backgroundColor = [UIColor whiteColor];
    self.searchBar.delegate = self;
    
    //关闭按钮
    UIImage *image = [UIImage imageNamed:@"btn_navigation_close_hl"] ;
    image =  [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(backToVC:)];
    self.navigationItem.leftBarButtonItem = item;


    
    [self getData];
    
}


- (void)backToVC:(UINavigationItem *)bar
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void) getData
{
    self.lessonArray = [[NSMutableArray alloc]initWithCapacity:10];
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"categories" ofType:@"plist"];
    NSArray *data = [[NSArray alloc] initWithContentsOfFile:plistPath];
    for (NSDictionary *dic in data) {
        NSArray *keys = dic.allKeys;
        for (NSString *key in keys) {
            if ([key isEqualToString:@"subcategories"]) {
                NSArray *array = dic[@"subcategories"];
               for (NSString *str  in array) {
                    [self.lessonArray addObject:str];
               }
            }
        }
    }
    //    [self.tableView reloadData];
}

-(NSMutableArray *)resultArray{
    if (!_resultArray) {
        _resultArray = [[NSMutableArray alloc]init];
        
    }
    return _resultArray;
}



#pragma mark searchBar的代理方法
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    //如果是ipad手机
    if ([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length) {
        self.tableView.hidden = NO;
        [self.resultArray removeAllObjects];
        for (NSString *lesson in self.lessonArray) {
            NSString *lower = [lesson lowercaseString];
            NSString *upper = [lesson uppercaseString];
            if ([lesson hasPrefix:searchText]  ||  [lower hasPrefix:searchText] || [upper hasPrefix:searchText]) {
                [self.resultArray addObject:lesson];
            }
        }
        [self.tableView reloadData];
    }
    else{
        self.tableView.hidden = YES;
        
    }
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    self.tableView.hidden = YES;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark tableView代理方法
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.resultArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell ==nil ) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] ;
    }
    cell.textLabel.text = self.resultArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LearnViewController *lvc = [[LearnViewController alloc]init];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    lvc.lesssonName = cell.textLabel.text;
    [self.navigationController pushViewController:lvc animated:YES];
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
