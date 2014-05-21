#import <UIKit/UIKit.h>
#import <Preferences/Preferences.h>
#import <LibGuest/LibGuest.h>

@interface LGPluginSettingsPanel : UITableViewCell
@property (nonatomic, retain) id<LGPlugin> plugin;

@end