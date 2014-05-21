#import "LGSettings.h"
#import "LibGuest.h"
#define PLUGIN_PATH @"/Library/GuestFramework/Plugins/"
#define SETTINGS_FILE @"/var/mobile/Library/Preferences/com.efrederickson.guestframework.plist"

@interface NSObject (LibGuest)
-(id) initWithBundle:(NSBundle*)bundle;
@end


@implementation LibGuest : NSObject
+(instancetype) sharedInstance
{
    static LibGuest *instance;
    if (!instance)
        instance = [[LibGuest alloc] init];
    
    return instance;
}
-(id) init
{
    delegates = [[NSMutableArray alloc] init];
    return [super init];
}

-(BOOL) isPluginRegistered:(id)delegate
{
    return [delegates indexOfObject:delegate] != NSNotFound;
}

-(void) registerPlugin:(id<LGPlugin>)plugin
{
    if ([self isPluginRegistered:plugin] || plugin == nil)
        return;
    
    [delegates addObject:plugin];
}

-(void) deregisterPlugin:(id<LGPlugin>)plugin
{
    if (![self isPluginRegistered:plugin] || plugin == nil)
        return;
    
    NSUInteger num = [delegates indexOfObject:plugin];
    if (NSNotFound == num)
        return;
    [delegates removeObjectAtIndex:num];
}

- (void) loadPluginFromBundle:(NSBundle*)bundle
{
	Class pluginClass = nil;
	if ([bundle objectForInfoDictionaryKey:@"CFBundleExecutable"])
    {
		NSError *error = nil;
		if ([bundle loadAndReturnError:&error]) {
			NSString *principalClass = [bundle objectForInfoDictionaryKey:@"NSPrincipalClass"];
			if (principalClass) {
				pluginClass = NSClassFromString(principalClass);
			}
		} else {
			NSLog(@"GuestFramework: Failed to load plugin: %@", error);
		}
	} else {
		NSString *principalClass = [bundle objectForInfoDictionaryKey:@"NSPrincipalClass"];
		if (principalClass) {
			pluginClass = NSClassFromString(principalClass);
		}
	}
	if (pluginClass) {
		id<LGPlugin> actualPlugin = [pluginClass instancesRespondToSelector:@selector(initWithBundle:)] ? [[pluginClass alloc] initWithBundle:bundle] : [[pluginClass alloc] init];
		if (actualPlugin) {
            //NSLog(@"GuestFramework: successfully loaded plugin %@", [actualPlugin pluginName]);
			[self registerPlugin:actualPlugin];
		}
	}
}

-(void) loadPlugins
{
    NSArray *directoryContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:PLUGIN_PATH error:nil];
	for (NSString *folder in directoryContents) {
		NSBundle *bundle = [NSBundle bundleWithPath:[PLUGIN_PATH stringByAppendingPathComponent:folder]];
		if (bundle) {
            //NSLog(@"GuestFramework: attempting to load plugin from %@", folder);
			[self loadPluginFromBundle:bundle];
		}
	}
}

-(void) reloadPlugins
{
    for (id plugin in delegates)
    {
        [plugin deactivate];
        [self deregisterPlugin:plugin];
    }
    delegates = [[NSMutableArray alloc] init];
    [self loadPlugins];
}

-(void) activate
{
    if ([LGSettings sharedInstance].enabled == NO)
        return;
        
    [[LibPass sharedInstance] unlockWithCodeEnabled:NO];
    for (id plugin in delegates)
    {
        if ([self isPluginEnabled:plugin])
            [plugin activate];
    }
    _isActive = YES;
}

-(void) deactivate
{
    for (id plugin in delegates)
    {
        if ([self isPluginEnabled:plugin])
            [plugin deactivate];
    }
    _isActive = NO;
}

-(BOOL) isActive
{
    return _isActive;
}

-(BOOL) isPluginEnabled:(id<LGPlugin>)plugin
{
    return [[LGSettings sharedInstance] isPluginEnabled:plugin];
}

-(void) enablePlugin:(id<LGPlugin>)plugin
{
    [[LGSettings sharedInstance] enablePlugin:plugin];
}

-(void) disablePlugin:(id<LGPlugin>)plugin
{
    [[LGSettings sharedInstance] disablePlugin:plugin];
}

@end




