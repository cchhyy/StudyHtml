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



@interface FirstViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,AwesomeMenuItemDelegate,AwesomeMenuDelegate,UIAlertViewDelegate>{
    UIBarButtonItem *_firstItem;
    UIBarButtonItem *_secondItem;
    UIBarButtonItem *_thirdItem;
    UIPopoverController *_pop1;
    UIPopoverController *_pop2;
    UIPopoverController *_pop3;
    UIAlertView *_alert;
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
    [self addBarItems];
    [self getDataByStringIndex:1];
    [self getDataByStringIndex:2];
    [self topUpdate];
    [self bottomUpdate];

}
#pragma mark 添加AwesomeMenu
-(void)addAwemenu{
    UIImage *storyMenuItemImage = [UIImage imageNamed:@"bg-menuitem.png"];
    UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"bg-menuitem-highlighted.png"];
    
    UIImage *starImage = [UIImage imageNamed:@"icon-star.png"];
    
    // Default Menu
    
    AwesomeMenuItem *starMenuItem1 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem2 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem3 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem4 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    
    NSArray *menuItems = [NSArray arrayWithObjects:starMenuItem1, starMenuItem2, starMenuItem3, starMenuItem4,  nil];
    
    AwesomeMenuItem *startItem = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"bg-addbutton.png"]
                                                       highlightedImage:[UIImage imageNamed:@"bg-addbutton-highlighted.png"]
                                                           ContentImage:[UIImage imageNamed:@"icon-plus.png"]
                                                highlightedContentImage:[UIImage imageNamed:@"icon-plus-highlighted.png"]];
    
    AwesomeMenu *menu = [[AwesomeMenu alloc] initWithFrame:CGRectMake(-90,ScreenHeight-360 , 0, 0) startItem:startItem menuItems:menuItems];
    menu.menuWholeAngle = M_PI_2;
    menu.delegate = self;
    [self.view addSubview:menu];
    NSLog(@"添加菜单成功");

}
#pragma mark collectionView的布局
-(void)flowLayOut{
    //1.创建一个布局类的对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //2.每个item的大小(不规则瀑布流不会直接使用该属性来设置大小)
    flowLayout.itemSize = CGSizeMake(220, 220);
    //3.设置最小列间距
    flowLayout.minimumInteritemSpacing = 20;
    //4.最小行间距
    flowLayout.minimumLineSpacing = 20;
    //5.滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //6.外部边距(上左下右）
    flowLayout.sectionInset = UIEdgeInsetsMake(20, 30, 20, 30);
    
    self.collectionView.collectionViewLayout = flowLayout;
}

#pragma mark 添加导航栏按钮
-(void)addBarItems{
    //添加导航栏左边的按钮
    UIImage *logoImage=[UIImage imageNamed: @"logo.png"];
    logoImage = [logoImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *logoBarBtnItem = [[UIBarButtonItem alloc]initWithImage:logoImage style:UIBarButtonItemStyleDone target:nil  action:nil];

    NavItem *first = [NavItem makeItem];
    NavItem *second = [NavItem makeItem];
    NavItem *third = [NavItem makeItem];
    
    [second.button setNormalImage:@"icon_category_20" highlightedImage:@"icon_category_highlighted_20"];
    [third.button setNormalImage:@"icon_category_22" highlightedImage:@"icon_category_highlighted_22"];
    second.smallLabel.text = @"查询";
    second.bigLabel.text = @"薪资水平";
    third.smallLabel.text = @"演示";
    third.bigLabel.text = @"经典Demo";
    
    [first addTarget:self  action:@selector(firstClick:)];
    [second addTarget:self action:@selector(secondClick:)];
    [third addTarget:self action:@selector(thirdClick:)];
    
    _firstItem = [[UIBarButtonItem alloc]initWithCustomView:first];
     _secondItem = [[UIBarButtonItem alloc]initWithCustomView:second];
    _thirdItem = [[UIBarButtonItem alloc]initWithCustomView:third];
    
    self.navigationItem.leftBarButtonItems = @[logoBarBtnItem,_firstItem,_secondItem,_thirdItem];
    
    //添加导航栏右边的按钮
    UIImage *searchImage = [UIImage imageNamed:@"icon_search"];
    searchImage = [searchImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *searchBarItem = [[UIBarButtonItem alloc]initWithImage:searchImage  style:UIBarButtonItemStyleDone target:self action:@selector(searchLesson:)];
    self.navigationItem.rightBarButtonItem = searchBarItem;
}

#pragma mark barButtonItem的点击事件
-(void)searchLesson:(UIBarButtonItem *)searchBarBtnItem{
    if (_pop1.popoverVisible) {
        [_pop1 dismissPopoverAnimated:YES];
    }
    if (_pop2.popoverVisible) {
        [_pop2 dismissPopoverAnimated:YES];
    }
    if (_pop3.popoverVisible) {
        [_pop3 dismissPopoverAnimated:YES];
    }
    SearchViewController *svc = [[SearchViewController alloc]init];
    MyNavController *nav = [[MyNavController alloc]initWithRootViewController:svc];
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:nav animated:YES completion:nil];
}
-(void)firstClick:(NavItem *)navItem{
    if (_pop2.popoverVisible) {
        [_pop2 dismissPopoverAnimated:YES];
    }
    if (_pop3.popoverVisible) {
        [_pop3 dismissPopoverAnimated:YES];
    }
    [self creatPopViewController];

}

-(void)secondClick:(NavItem *)navItem{
    if (_pop1.popoverVisible) {
        [_pop1 dismissPopoverAnimated:YES];
    }
    if (_pop3.popoverVisible) {
        [_pop3 dismissPopoverAnimated:YES];
    }
    [self createSecondPopver];

}

-(void)thirdClick:(NavItem *)navItem{
    if (_pop1.popoverVisible) {
        [_pop1 dismissPopoverAnimated:YES];
    }
    if (_pop2.popoverVisible) {
        [_pop2 dismissPopoverAnimated:YES];
    }
    [self createThirdPopover];
}

#pragma mark - 第一个下拉菜单

-(void)creatPopViewController{
    FirstPopViewController *pVc = [[FirstPopViewController alloc]init];
    _pop1 = [[UIPopoverController alloc]initWithContentViewController:pVc];
    [_pop1 presentPopoverFromBarButtonItem:_firstItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}


#pragma mark - 第二个下拉菜单
- (void)createSecondPopver{
    SecondPopViewController *svc = [[SecondPopViewController alloc]initWithNibName:@"SecondPopViewController" bundle:nil];;
    _pop2 = [[UIPopoverController alloc]initWithContentViewController:svc];
    [_pop2 presentPopoverFromBarButtonItem:_secondItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}
#pragma mark - 第三个下拉菜单
-(void)createThirdPopover{
    ThirdPopViewController *tvc = [[ThirdPopViewController alloc]init];
    _pop3 = [[UIPopoverController alloc]initWithContentViewController:tvc];
    [_pop3 presentPopoverFromBarButtonItem:_thirdItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

#pragma mark 懒加载
-(NSMutableArray *)modelArray
{
    if (_modelArray == nil) {
        _modelArray = [[NSMutableArray alloc]init];
    }
    return _modelArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    if ([self.collectionView.legendHeader isRefreshing]) {
        [self.collectionView.legendHeader endRefreshing];
    }
    if ([self.collectionView.legendFooter isRefreshing]) {
        [self.collectionView.legendFooter endRefreshing];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
//    MyNavController *nav = [[MyNavController alloc]initWithRootViewController:dvc];
//    [self.navigationController presentViewController:nav
//                                            animated:YES completion:nil];
    [self.navigationController pushViewController:dvc animated:YES];
}

#pragma mark 上下拉刷新
-(void)topUpdate{
    __weak typeof(self) WeakSelf = self;
    [self.collectionView addLegendHeaderWithRefreshingBlock:^{
        [WeakSelf.modelArray removeAllObjects];
        [WeakSelf getDataByStringIndex:1];
        [WeakSelf getDataByStringIndex:2];
        [WeakSelf getDataByStringIndex:3];
    }];
    self.collectionView.header.updatedTimeHidden = NO;
    
    [self.collectionView.legendHeader beginRefreshing];
}

-(void)bottomUpdate{
    static int  i = 4;
        __weak typeof(self) WeakSelf = self;
        [self.collectionView addLegendFooterWithRefreshingBlock:^{
            [WeakSelf getDataByStringIndex:i];
             i++;
            NSLog(@"++++i = %d",i);
        }];
        [self.collectionView.footer beginRefreshing];
         NSLog(@"i = %d",i);
}




/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

/* ⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇ */
/* ⬇⬇⬇⬇⬇⬇ GET RESPONSE OF MENU ⬇⬇⬇⬇⬇⬇ */
/* ⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇ */
//关于，//免责声明，联系方式，清除缓存
- (void)awesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx
{
//    UIModalTransitionStyleCoverVertical = 0,
//    UIModalTransitionStyleFlipHorizontal,
//    UIModalTransitionStyleCrossDissolve,
//    UIModalTransitionStylePartialCurl NS_ENUM_AVAILABLE_IOS(3_2),
    NSLog(@"Select the index : %ld",(long)idx);
    switch (idx) {
        case 0:
             [self presentSettingViewControllerWithText:@"本应用提供给喜欢学习的你，可以学习HTML的基础知识，可以查询前端工程师的大概薪资，可以观看一些简单的Demo，还可以收看到定期更新的热门行业资讯，希望您喜欢"];
            break;
        case 1:
            [self presentSettingViewControllerWithText:@"本App数据均来源于互联网，学习资料部分经过个人修改制作。如有侵权，请联系我，会尽快进行处理"];
            break;
        case 2:
            [self presentSettingViewControllerWithText:@"联系方式：chenhuaizhe@gmail.com"];
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

-(void)AwesomeMenuItemTouchesBegan:(AwesomeMenuItem *)item{
    
}

-(void)AwesomeMenuItemTouchesEnd:(AwesomeMenuItem *)item{
    
}

-(void)presentSettingViewControllerWithText:(NSString *)text{
    SettingViewController *svc = [[SettingViewController alloc]init];
    svc.modalTransitionStyle =  UIModalTransitionStyleCrossDissolve;
    svc.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:svc animated:YES completion:nil];
    svc.preferredContentSize = CGSizeMake(320, 350);
    svc.setingLabel.text = text;
}



@end
