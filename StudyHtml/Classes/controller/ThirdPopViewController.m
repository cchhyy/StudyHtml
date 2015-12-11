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
#import "TFHpple.h"

@interface ThirdPopViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong) AnimationListView *animationListView;
@property (nonatomic,strong ) NSMutableArray *modelArray;
@property (nonatomic,strong) NSArray *readyArray;
@property (nonatomic,assign) BOOL notFirst;

@end

@implementation ThirdPopViewController
-(void)loadView{
    [super loadView];
    self.readyArray = @[
                        @"http://chuye.cloud7.com.cn/7854771",
                        @"http://chuye.cloud7.com.cn/7724167",
                        @"http://chuye.cloud7.com.cn/7734823",
                        @"http://chuye.cloud7.com.cn/7545792",
                        @"http://chuye.cloud7.com.cn/7712691",
                        @"http://chuye.cloud7.com.cn/7734710",
                        @"http://chuye.cloud7.com.cn/7741569"
                        ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.preferredContentSize = CGSizeMake(300, 500);
    [self addAnimationView];
    
}

-(void)addAnimationView{
    AnimationListView *ani = [[AnimationListView alloc]init];
    self.animationListView = ani;
    [self.view addSubview:self.animationListView];
    self.animationListView.delegate = self;
    self.animationListView.dataSource = self;
    [self.animationListView addFooterRefreshWithTarget:self action:@selector(refreshing)];
    //隐藏
    self.animationListView.showsVerticalScrollIndicator = NO;
}



#pragma mark 代理方法
-(NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (!self.notFirst) {
         self.notFirst = YES;
        return 9;
    }else{
        return self.modelArray.count;
    }
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AnimationListViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"listCell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.listLabel.text  = @"日历";
    }else if (indexPath.row == 1){
        cell.listLabel.text  = @"开发者博客";
    }else if (indexPath.row ==2){
        cell.listLabel.text  = @"本应用的HTML宣传图";
    }else{
        cell.listLabel.text = [NSString stringWithFormat:@"其他优秀作品展示 %ld",(long)indexPath.row-2];

    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HTMLAnimationController *hvc;
    MyNavController *nav;
//     NSString *fileName = [NSString stringWithFormat:@"animation1.html"];
    switch (indexPath.row) {
        case 0:
            hvc = [[HTMLAnimationController alloc]init];
            hvc.url = @"http://www.html5tricks.com/demo/html5-date-range-picker/index.html";
            nav = [[MyNavController alloc]initWithRootViewController:hvc];
            nav.modalPresentationStyle =  UIModalPresentationFormSheet;
            break;
        case 1:hvc = [[HTMLAnimationController alloc]init];
                      hvc.url = @"https://chenhuaizhe.github.io/";
            nav = [[MyNavController alloc]initWithRootViewController:hvc];
            nav.modalPresentationStyle =  UIModalPresentationFormSheet;
            break;
        default:
                      hvc = [[HTMLAnimationController alloc]init];
               hvc.url =  self.modelArray[indexPath.row-2];
            nav = [[MyNavController alloc]initWithRootViewController:hvc];
            break;
    }

    [self presentViewController:nav animated:YES completion:nil];
    
}
#pragma mark 懒加载
-(NSMutableArray *)modelArray{
    if (!_modelArray) {
        _modelArray = [[NSMutableArray alloc]init];
        for (NSString *str in self.readyArray) {
            [self.modelArray addObject:str];
        }
    }
    return _modelArray;
}





#pragma mark HTML解析，获取数据 text
-( NSString *) getDataWithGitRowIndex:(NSInteger )rowIndex
{
    //1.获取到html的NSData 数据
    NSString *string =@"https://github.com/cchhyy/ForBlogs/blob/master/Data/cyh5.html";
    NSString *string1 = [NSString stringWithContentsOfURL:[NSURL URLWithString:string] encoding:NSUTF8StringEncoding error:nil];
    NSData *htmlData = [string1 dataUsingEncoding:NSUTF8StringEncoding];
    
    //    2.解析html数据
    TFHpple *xpathParser = [[TFHpple alloc]initWithHTMLData:htmlData];
    //    3.根据biaoq来进行过滤
    NSArray *dataArray = [xpathParser searchWithXPathQuery:@"//td"];
    
    //    4.开始整理数据
    for (TFHppleElement *hppleElement in dataArray) {
    
        //过滤指定数据
//               NSLog(@"%@",hppleElement);
        NSString *rowString = [NSString stringWithFormat:@"LC%ld",(long)rowIndex];
        if ([[hppleElement objectForKeyedSubscript:@"id"]isEqualToString:rowString] ) {
//                    NSLog(@"%@",hppleElement.text);
            return   hppleElement.text;
            
        }
    }
    return nil;

}

-(void)getUrlAtRow:(NSInteger )row
{
    NSString *baseUrl = [self getDataWithGitRowIndex:9];
//    NSLog(@"baseUrl = %@",baseUrl);
//    for (int i = 11; i<19; i++) {
    
   
     NSString *string  = [self getDataWithGitRowIndex:row];
//        NSLog(@"urlString = %@",string);
    NSArray  *array = [string componentsSeparatedByString:@","];
    NSLog(@"array = %@",array);
    for (int i = 0; i < array.count-1; i++) {
        NSString *urlStr = [baseUrl stringByAppendingString:array[i]];
        NSLog(@"%@",urlStr);
        [self.modelArray addObject:urlStr];
    }
 
}

#pragma mark 刷新
-(void)refreshing{

    static int  i = 11;
    if (i<19) {
        [self getUrlAtRow:i];
        [self.animationListView reloadData];
        i++;
    }
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
