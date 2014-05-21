#import "LibGuest.h"

@interface LGSettings : NSObject
{
    NSMutableDictionary *prefs;
}
+(instancetype) sharedInstance;
-(void) reloadSettings;

-(BOOL) isPluginEnabled:(id<LGPlugin>)plugin;
-(void) enablePlugin:(id<LGPlugin>)plugin;
-(void) disablePlugin:(id<LGPlugin>)plugin;

@property (nonatomic) BOOL enabled;
@property (nonatomic) BOOL acceptAnyPassword;
@property (nonatomic) BOOL acceptCertainPassword;
@property (nonatomic, retain) NSString *guestPasscode;
@end