//
//  FirstViewController.m
//  StudyHtml
//
//  Created by ccyy on 15/7/16.
//  Copyright (c) 2015年 ccyy. All rights reserved.
//

#import "FirstViewController.h"
#import "CommonDefine.h"
#import "NavItem.h"
#import "FirstPopViewController.h"
#import "SecondPopViewController.h"
#import "ThirdPopViewController.h"
#import "UIButton+CCYY.h"
#import "MyCollectionViewCell.h"
#import "ImageModel.h"
#import "UIImageView+WebCache.h"//sd第三方
#import "AwesomeMenu.h"
#import "DKWebViewController.h"
#import "MyNavController.h"
#import "TFHpple.h"
#import "SearchViewController.h"
#import "SettingViewController.h"
#import "SDImageCache.h"
#import "MJRefresh.h"
#import "MusicViewController.h"
#import "ActionSheet.h"
#import "CollectViewController.h"
#import "AddBarButtons.h"
#import "GCD.h"



@interface FirstViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,AwesomeMenuDelegate,UIAlertViewDelegate>{

    UIAlertView *_alert;
    ActionSheet *_actionSheet;
    AddBarButtons *_abb;
}

@property (strong,nonatomic) NSMutableArray *modelArray;
@end

@implementation FirstViewController

static NSString * const reuseIdentifier = @"Cell";

-(instancetype)init{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    return [self initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    
    // Do any additional setup after loading the view.
    [self flowLayOut];

    [self addAwemenu];
//添加导航栏按钮
    _abb = [[AddBarButtons alloc]init];
    [_abb addBarButtonsInController:self];
    
//获取collectionView数据
    [self getDataByStringIndex:1];
    [self getDataByStringIndex:2];
    
//上拉下拉刷新
    [self topUpdate];
    [self bottomUpdate];

}
#pragma mark 添加AwesomeMenu
-(void)addAwemenu{
    UIImage *storyMenuItemImage = [UIImage imageNamed:@"bg-menuitem.png"];
    UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"bg-menuitem-highlighted.png"];
    
//    UIImage *starImage = [UIImage imageNamed:@"icon-star.png"];
    
    // Default Menu
    
    AwesomeMenuItem *starMenuItem1 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImage
                                                               ContentImage:[UIImage imageNamed:@"iconfont-iconfontcolor"]
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem2 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:[UIImage imageNamed:@"iconfont-shoucang@2x"]
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem3 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:[UIImage imageNamed:@"iconfont-icon"]
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem4 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:[UIImage imageNamed:@"iconfont-clean@2x"]
                                                    highlightedContentImage:nil];
    
    NSArray *menuItems = [NSArray arrayWithObjects:starMenuItem1, starMenuItem2, starMenuItem3, starMenuItem4,  nil];
    
    AwesomeMenuItem *startItem = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"Image"]
                                                       highlightedImage:[UIImage imageNamed:@"bg-addbutton-highlighted.png"]
                                                           ContentImage:[UIImage imageNamed:@"icon-plus.png"]
                                                highlightedContentImage:[UIImage imageNamed:@"icon-plus-highlighted.png"]];
    
    AwesomeMenu *menu = [[AwesomeMenu alloc] initWithFrame:CGRectMake(-110,ScreenHeight-370 , 0, 0) startItem:startItem menuItems:menuItems];
    menu.menuWholeAngle = M_PI_2;
    menu.delegate = self;
    [self.view addSubview:menu];
//    NSLog(@"添加菜单成功");

}


#pragma mark 显示第一个下拉菜单
-(void)firstClick:(NavItem *)navItem{
     self.navItemIndex = 1;
    [_abb clickInController:self];
   
}

#pragma mark 显示第二个下拉菜单
-(void)secondClick:(NavItem *)navItem{
       self.navItemIndex = 2;
    [_abb clickInController:self];
 
}
#pragma mark 显示第三个下拉菜单
-(void)thirdClick:(NavItem *)navItem{
        self.navItemIndex = 3;
    [_abb clickInController:self];

}

#pragma mark 搜索
-(void)searchLesson:(UIBarButtonItem *)searchBarBtnItem
{
    [_abb searchLesson:searchBarBtnItem];
}

#pragma mark 音乐
-(void)playMusic:(UIButton *)btn{
    [_abb playMusicInController:self];
}


#pragma mark collectionView的布局
-(void)flowLayOut{
    //1.创建一个布局类的对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //2.每个item的大小(不规则瀑布流不会直接使用该属性来设置大小)
    flowLayout.itemSize = CGSizeMake((self.view.bounds.size.width-70)/3, (self.view.bounds.size.width-70)/3);
    //3.设置最小列间距
    flowLayout.minimumInteritemSpacing = 15;
    //4.最小行间距
    flowLayout.minimumLineSpacing = 15;
    //5.滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //6.外部边距(上左下右）
    flowLayout.sectionInset = UIEdgeInsetsMake(20, 10, 20, 20);
    
    self.collectionView.collectionViewLayout = flowLayout;
}
#pragma mark 懒加载
-(NSMutableArray *)modelArray
{
    if (_modelArray == nil) {
        _modelArray = [[NSMutableArray alloc]init];
    }
    return _modelArray;
}


#pragma mark 获取数据
-(void)getDataByStringIndex:(int )index{
    //1.获取到html的NSData 数据
     NSString *string = [NSString stringWithFormat:@"http://news.html5cn.org/index.php?page=%d",index];
    NSString *string1 = [NSString stringWithContentsOfURL:[NSURL URLWithString:string] encoding:NSUTF8StringEncoding error:nil];
    NSData *htmlData = [string1 dataUsingEncoding:NSUTF8StringEncoding];
    
    //    2.解析html数据
    TFHpple *xpathParser = [[TFHpple alloc]initWithHTMLData:htmlData];
    //    3.根据biaoq来进行过滤
    NSArray *dataArray = [xpathParser searchWithXPathQuery:@"//div"];
    
    //    4.开始整理数据
    for (TFHppleElement *hppleElement in dataArray) {
        ImageModel *imageModel = [[ImageModel alloc]init];
        //过滤指定数据
//        NSLog(@"%@",hppleElement);
        if ([[hppleElement objectForKeyedSubscript:@"class"]isEqualToString:@"atc"] ) {
            //            NSLog(@"%@",hppleElement.firstChild.tagName);
            NSDictionary *dic = [hppleElement.firstChild attributes];
            //获得url
            NSString *str = dic[@"href"];
            [imageModel setValue:str forKey:@"url"];
            //获得src和title
            TFHppleElement *aElement  =(TFHppleElement *) hppleElement.firstChild;
            NSDictionary *dic1 = aElement.firstChild.attributes;
            [imageModel setValue:dic1[@"alt"] forKey:@"title"];
        
            NSString *str1 = dic1[@"src"] ;
            NSString *src = [NSString stringWithFormat:@"http://news.html5cn.org/%@",str1];
            [imageModel setValue:src forKey:@"src"];
            [self.modelArray addObject:imageModel];
        }
    }
    [self.collectionView reloadData];
    if ([self.collectionView.header isRefreshing]) {
        [self.collectionView.header endRefreshing];
    }
    if ([self.collectionView.footer isRefreshing]) {
        [self.collectionView.footer endRefreshing];
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.modelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    ImageModel *model = self.modelArray[indexPath.row];
    cell.label.text = model.title;
   NSURL *imageUrl = [NSURL URLWithString:model.src];
    int a = arc4random()%10+1;
//    NSLog(@"***************%d",a);
   [cell.imageView1  sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"zhanweitu_%d",a]]];
    return cell;
}



#pragma mark <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageModel *model = self.modelArray[indexPath.row];
    DKWebViewController *dvc = [[DKWebViewController alloc]initWithStringURL:model.url];
    dvc.url = model.url;
    dvc.newsTitle = model.title;
    [self.navigationController pushViewController:dvc animated:YES];
}

#pragma mark 上下拉刷新
-(void)topUpdate{
    [GCDQueue executeInGlobalQueue:^{
        __weak typeof(self) WeakSelf = self;
        [self.collectionView addLegendHeaderWithRefreshingBlock:^{
            [WeakSelf.modelArray removeAllObjects];
            [WeakSelf getDataByStringIndex:1];
            [WeakSelf getDataByStringIndex:2];
            [WeakSelf getDataByStringIndex:3];
        }];
    }];

    
}

-(void)bottomUpdate{
    [GCDQueue executeInGlobalQueue:^{
        static int  i = 4;
        __weak typeof(self) WeakSelf = self;
        [self.collectionView addLegendFooterWithRefreshingBlock:^{
            [WeakSelf getDataByStringIndex:i];
            i++;
        }];
    }];

}





/* ⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇ */
/* ⬇⬇⬇⬇⬇⬇ GET RESPONSE OF MENU ⬇⬇⬇⬇⬇⬇ */
/* ⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇ */
//关于，//免责声明，联系方式，清除缓存
- (void)awesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx
{
    switch (idx) {
        case 0:{
            _actionSheet = [ActionSheet alertControllerWithTitle:@"设置" message:@"请选择您想查看的内容" preferredStyle:UIAlertControllerStyleActionSheet];
            [_actionSheet addActionsActionByController:self];
            break;
        }
        case 1:{
         CollectViewController *dvc  =  [[CollectViewController alloc]init];
            MyNavController *nav = [[MyNavController alloc]initWithRootViewController:dvc];
            nav.modalPresentationStyle = UIModalPresentationFormSheet;
            [self presentViewController:nav animated:YES completion:nil];
            break;
        }
        case 2:
             _actionSheet = [ActionSheet alertControllerWithTitle:@"评价" message:@"如果喜欢，就给我们好评吧" preferredStyle:UIAlertControllerStyleActionSheet];
            [_actionSheet addScoreAppByController:self];
            break;
        case 3:
        {
            NSString *str  = [NSString stringWithFormat:@"共有%@缓存",[SDImageCache getSizeAutoWithMBKB]];
            _alert =[ [UIAlertView alloc]initWithTitle:@"清除缓存" message: str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [_alert show];
        }
            break;
            
        default:
            break;
    }
   
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1 && alertView == _alert) {
        [[SDImageCache sharedImageCache]clearDiskOnCompletion:^{
            NSLog(@"内存已经清除");
            UIAlertView  *alert =[ [UIAlertView alloc]initWithTitle:@"提示" message:@"缓存已清除" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
    
        }];
    }
}

- (void)awesomeMenuDidFinishAnimationClose:(AwesomeMenu *)menu {
    NSLog(@"Menu was closed!");
}
- (void)awesomeMenuDidFinishAnimationOpen:(AwesomeMenu *)menu {
    NSLog(@"Menu is open!");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
