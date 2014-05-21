#import "LGSettings.h"
#import "LibGuest.h"
#define SETTINGS_FILE @"/var/mobile/Library/Preferences/com.efrederickson.guestframework.plist"

@implementation LGSettings
+(instancetype)sharedInstance
{
    static LGSettings *instance;
    if (!instance)
    {
        instance = [[LGSettings alloc] init];
        [instance reloadSettings];
    }
    return instance;
}

-(id) init
{
    self = [super init];
    
    return self;
}

-(void) reloadSettings
{
    // Load the settings file
    if (prefs)
        prefs = nil;
    prefs = [NSMutableDictionary dictionaryWithContentsOfFile:SETTINGS_FILE];
    
    // This loads settings, defaulting to YES if the key doesn't exist in the file
    self.enabled = [prefs objectForKey:@"enabled"] != nil ? [[prefs objectForKey:@"enabled"] boolValue] : YES;
    self.acceptAnyPassword = [prefs objectForKey:@"acceptAnyPassword"] != nil ? [[prefs objectForKey:@"acceptAnyPassword"] boolValue] : YES;
}

-(BOOL) isPluginEnabled:(id<LGPlugin>)plugin
{
    return [prefs objectForKey:[plugin uniqueIdentifier]] != nil ? [[prefs objectForKey:[plugin uniqueIdentifier]] boolValue] : YES;
}

-(void) enablePlugin:(id<LGPlugin>)plugin
{
    if (!prefs)
        prefs = [[NSMutableDictionary alloc] init];
    [prefs setObject:@YES forKey:[plugin uniqueIdentifier]];
    [prefs writeToFile:SETTINGS_FILE atomically:YES];
}

-(void) disablePlugin:(id<LGPlugin>)plugin
{
    if (!prefs)
        prefs = [[NSMutableDictionary alloc] init];
    [prefs setObject:@NO forKey:[plugin uniqueIdentifier]];
    [prefs writeToFile:SETTINGS_FILE atomically:YES];
}
@end