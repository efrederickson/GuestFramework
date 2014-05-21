#import <Preferences/Preferences.h>
#import <LibGuest/LibGuest.h>

@interface LGPluginSubPanel : PSListController
{
    id<LGPlugin> plugin;
}
-(id) initWithPlugin:(id<LGPlugin>)plugin;
@end