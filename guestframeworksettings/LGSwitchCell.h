#import <UIKit/UIKit.h>
#import <Preferences/Preferences.h>
#import <LibGuest/LibGuest.h>

@interface LGSwitchCell : UITableViewCell {
	UISwitch *switchView;
}

@property (nonatomic, readonly) UISwitch *switchView;
@property (nonatomic, retain) id<LGPlugin> plugin;

-(void) checkValue;

@end