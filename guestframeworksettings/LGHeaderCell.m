#import "LGHeaderCell.h"

@interface PSTableCell (GuestFramework)
@property (nonatomic, retain) UIView *backgroundView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end

@interface UIImage (Private)
+ (UIImage *)imageNamed:(NSString *)named inBundle:(NSBundle *)bundle;
@end

@implementation LGHeaderCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])){
        UIImage *bkIm = [UIImage imageNamed:@"logo.png" inBundle:[NSBundle bundleForClass:self.class]];
        _background = [[UIImageView alloc] initWithImage:bkIm];
        //_background.frame = [self frame];
        //[_background setContentMode:UIViewContentModeCenter];
        //[_background setCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))];
        [self addSubview:_background];
    }
    return self;
}
@end