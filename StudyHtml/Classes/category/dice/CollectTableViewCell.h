

#import <UIKit/UIKit.h>

typedef enum DiceTableViewCellScrollDirection : NSInteger {
    ScrollDirectionNone = 0,
    ScrollDirectionRight,
    ScrollDirectionLeft,
    ScrollDirectionUp,
    ScrollDirectionDown,
    ScrollDirectionCrazy,
} DiceTableViewCellScrollDirection;

#define DiceTableViewCellDirectionNotification @"DiceTableViewCellDirectionNotification"
#define DiceTableViewMaximumOffset 40.0f
#define DiceTableViewOffsetFactor 0.25f

@interface CollectTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageViewBackground;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

