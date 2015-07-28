//
//  PopViewController.m
//  StudyHtml
//
//  Created by ccyy on 15/7/16.
//  Copyright (c) 2015年 ccyy. All rights reserved.
//

#import "FirstPopViewController.h"
#import "PopView.h"
#import "MJExtension.h"
#import "CategoriyModel.h"
#import "LearnViewController.h"
#import "MyNavController.h"

@interface FirstPopViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet PopView *popView;
@property (weak, nonatomic) IBOutlet UITableView *leftTV;
@property (weak, nonatomic) IBOutlet UITableView *rightTV;
@property (strong,nonatomic) CategoriyModel *selectedModel;//左边表格选中的模型
@property (strong,nonatomic) NSArray *modelArray;//存储左侧列表的数据

@end

@implementation FirstPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.popView = [[[NSBundle mainBundle] loadNibNamed:@"PopView" owner:self options:nil] firstObject];
 
    self.modelArray = [CategoriyModel objectArrayWithFilename:@"categories.plist"];
    //让页面自动适配设置的popView的大小
    self.popView.autoresizingMask = UIViewAutoresizingNone;
    self.preferredContentSize = CGSizeMake(self.popView.frame.size.width, self.popView.frame.size.height);

}


#pragma mark 代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 
    
        if (tableView == _leftTV) {
            return self.modelArray.count;
        }else{
            NSArray *array = self.selectedModel.subcategories;
            return array.count;
        }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _leftTV) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"aCell"];
        }
        CategoriyModel *cat = _modelArray[indexPath.row];
        cell.textLabel.text = cat.name;
        cell.imageView.image = [UIImage imageNamed:cat.small_icon];
        if (cat.subcategories.count) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"bCell"];
        }
        cell.textLabel.text = self.selectedModel.subcategories[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _leftTV) {
        self.selectedModel = self.modelArray[indexPath.row];
        [self.rightTV reloadData];
    }
    if (tableView == _rightTV) {
        NSString *str = self.selectedModel.subcategories[indexPath.row];
        LearnViewController *lvc = [[LearnViewController alloc]init];
        MyNavController *nav = [[MyNavController alloc]initWithRootViewController:lvc];
        [self presentViewController:nav animated:YES completion:nil];
        lvc.lesssonName = str;
    }
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
