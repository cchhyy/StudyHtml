//
//  PopView.m
//  StudyHtml
//
//  Created by ccyy on 15/7/16.
//  Copyright (c) 2015年 ccyy. All rights reserved.
//

#import "PopView.h"
#import "CategoriyModel.h"
@interface PopView( )<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;

@end

@implementation PopView

//+( PopView *)makePopView{
//    return [[[NSBundle mainBundle]loadNibNamed:@"PopView" owner:self options:nil] firstObject];
//}

#pragma mark 代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%@",self.leftTableView);
    
    NSLog(@"%@",self.rightTableView);

//    if (tableView == _leftTableView) {
//        return self.modelArray.count;
//    }else{
//        NSArray *array = self.selectedModel.subcategories;
//        return array.count;
//    }
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"____________________");
    if (tableView == _leftTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"aCell"];
        }
        CategoriyModel *cat = _modelArray[indexPath.row];
        cell.textLabel.text = cat.name;
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"bCell"];
        }
        return cell;
    }
}

@end
