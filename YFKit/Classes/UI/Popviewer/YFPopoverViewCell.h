

#import <UIKit/UIKit.h>
#import "YFPopoverAction.h"

UIKIT_EXTERN float const PopoverViewCellHorizontalMargin; ///< 水平间距边距
UIKIT_EXTERN float const PopoverViewCellVerticalMargin; ///< 垂直边距
UIKIT_EXTERN float const PopoverViewCellTitleLeftEdge; ///< 标题左边边距

@interface YFPopoverViewCell : UITableViewCell

@property (nonatomic, assign) YFPopoverViewStyle style;

/*! @brief 标题字体
 */
+ (UIFont *)titleFont;

/*! @brief 底部线条颜色
 */
+ (UIColor *)bottomLineColorForStyle:(YFPopoverViewStyle)style;

- (void)setAction:(YFPopoverAction *)action;

- (void)showBottomLine:(BOOL)show;

@end
