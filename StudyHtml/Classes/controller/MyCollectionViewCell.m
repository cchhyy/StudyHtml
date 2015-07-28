#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        CGFloat w = ([UIScreen mainScreen].bounds.size.width-40)/3;
        self.imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, w, 3*w/4)];
        self.imageView1.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.imageView1];
        
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, 3*w/4, ([UIScreen mainScreen].bounds.size.width-40)/3, w/4)];
        self.label.backgroundColor = [UIColor clearColor];
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            self.label.font = [UIFont systemFontOfSize:18.f ];
        }else{
            self.label.font = [UIFont systemFontOfSize:10.0f];
        }
//        self.label.alpha = 0.4;
        self.label.textColor = [UIColor blackColor];
        self.label.numberOfLines = 0 ;
        self.label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.label];
    }
    return self;
}
@end
