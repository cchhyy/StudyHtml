#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self.imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 220, 165)];
        self.imageView1.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.imageView1];
        
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, 165, 220, 55)];
        self.label.backgroundColor = [UIColor clearColor];
        self.label.font = [UIFont systemFontOfSize:18.f ];
//        self.label.alpha = 0.4;
        self.label.textColor = [UIColor blackColor];
        self.label.numberOfLines = 0 ;
        self.label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.label];
    }
    return self;
}
@end
