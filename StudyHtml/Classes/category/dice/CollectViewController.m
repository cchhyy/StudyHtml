
#import "CollectViewController.h"
#import "CollectTableViewCell.h"
#import "SQLiteManager.h"
#import "News.h"
#import "DKWebViewController.h"
#import "MyNavController.h"


@interface CollectViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic) CGPoint lastContentOffset;
@property (strong,nonatomic) NSMutableArray *newsArray;

@end

@implementation CollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"收藏";
    // Do any additional setup after loading the view, typically from a nib.
#pragma mark 获取数据
    self.newsArray =  [SQLiteManager findAllNews];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CollectTableViewCell" bundle:nil] forCellReuseIdentifier:@"CollectTableViewCell"];
    
    //关闭按钮
    UIImage *image = [UIImage imageNamed:@"btn_navigation_close_hl"] ;
    image =  [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(backToVC)];
    self.navigationItem.leftBarButtonItem = item;
    self.navigationItem.rightBarButtonItem  = self.editButtonItem;
}

- (void)backToVC{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    CollectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CollectTableViewCell" forIndexPath:indexPath];
    
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
    NSLog(@"dvc.newsTitle = %@",dvc.newsTitle);
    [self.navigationController pushViewController:dvc animated:YES];
    
    //取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}





#pragma mark 删除
-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
    [tableView beginUpdates];
    [SQLiteManager deleteByID:(int)indexPath.row];
    [self.newsArray  removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [tableView endUpdates];
    }
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

