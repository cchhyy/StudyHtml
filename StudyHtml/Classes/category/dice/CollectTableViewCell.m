

#import "CollectTableViewCell.h"

@interface CollectTableViewCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintVerticalCenter;

@end

@implementation CollectTableViewCell

- (void)dealloc;
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)awakeFromNib {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDiceTableViewCellDirectionNotification:) name:DiceTableViewCellDirectionNotification object:nil];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews;
{

}

- (void)handleDiceTableViewCellDirectionNotification:(NSNotification *)notification;
{
    id notificationObject = notification.object;
    
    DiceTableViewCellScrollDirection scrollDirection = [(NSNumber *)notificationObject integerValue];
    
    CGFloat constant = self.constraintVerticalCenter.constant;
    
    switch (scrollDirection) {
        case ScrollDirectionUp:
        {
            constant -= DiceTableViewOffsetFactor;
            if (-1 * DiceTableViewMaximumOffset > constant)
            {
                constant = -1 * DiceTableViewMaximumOffset;
            }
        }
        break;
        case ScrollDirectionDown:
        {
            constant += DiceTableViewOffsetFactor;
            if (DiceTableViewMaximumOffset < constant)
            {
                constant = DiceTableViewMaximumOffset;
            }
        }
        default:
        {
//            Do Nothing
        }
        break;
    }
    
    self.constraintVerticalCenter.constant = constant;
    
}

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
