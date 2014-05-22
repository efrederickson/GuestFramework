#import <LibGuest/LibGuest.h>
#import <Preferences/Preferences.h>
#define SETTINGS_FILE @"/var/mobile/Library/Preferences/com.efrederickson.guestframework.plist"
#define SETTINGS_FILE2 @"/var/mobile/Library/Preferences/com.efrederickson.guestframework.plugins.iconrestrictor.plist"

@class SBAppSliderScrollingViewController;
@interface SBAppSliderWindow : UIWindow
@end

@interface SBAppSliderSnapshotView {
    UIImageView *_snapshotImage;
}
+(id)appSliderSnapshotViewForApplication:(id)application orientation:(int)orientation loadAsync:(BOOL)async withQueue:(id)queue statusBarCache:(id)cache;
@end
@interface SBApplication
-(id)bundleIdentifier;
-(BOOL)isRunning;
@end

BOOL active = NO;

BOOL disableSwitcher = YES;
BOOL blurDisabledApps = YES;
BOOL disableClosingApps = YES;

static void reloadSettings(CFNotificationCenterRef center,
                                    void *observer,
                                    CFStringRef name,
                                    const void *object,
                                    CFDictionaryRef userInfo)
{
    NSMutableDictionary *prefs = [NSMutableDictionary dictionaryWithContentsOfFile:SETTINGS_FILE];
    
    // This loads settings, defaulting to YES if the key doesn't exist in the file
    disableSwitcher = [prefs objectForKey:@"disableSwitcher"] != nil ? [[prefs objectForKey:@"disableSwitcher"] boolValue] : YES;
    blurDisabledApps = [prefs objectForKey:@"blurDisabledApps"] != nil ? [[prefs objectForKey:@"blurDisabledApps"] boolValue] : YES;
    disableClosingApps = [prefs objectForKey:@"disableClosingApps"] != nil ? [[prefs objectForKey:@"disableClosingApps"] boolValue] : YES;
}

@interface AppSwitcherPlugin : PSListController  <LGPlugin>
@end

@implementation AppSwitcherPlugin

-(void) activate
{
    active = YES;
}

-(void) deactivate
{
    active = NO;
}

-(NSString*) pluginName
{
    return @"AppSwitcher";
}
-(NSString*) author
{
    return @"Elijah Frederickson";
}

-(NSString*)uniqueIdentifier
{
    return @"com.efrederickson.guestframework.plugins.appswitcher";
}

-(id) preferenceSpecifiers
{
    return [self loadSpecifiersFromPlistName:@"AppSwitcher" target:self];
}

@end

%hook SBUIController
-(BOOL)_activateAppSwitcherFromSide:(int)side
{
    if (active && disableSwitcher)
        return NO;
    return %orig;
}
%end

%hook SBAppSliderController
-(BOOL)sliderScroller:(SBAppSliderScrollingViewController *)scroller isIndexRemovable:(NSUInteger)index {
	return active && disableClosingApps ? NO : %orig;
}

-(void)sliderScroller:(SBAppSliderScrollingViewController *)scroller itemWantsToBeRemoved:(NSUInteger)index {
    if (active && disableClosingApps)
        return;
        
        %orig;
}
%end

%hook SBAppSliderSnapshotView

+(id)appSliderSnapshotViewForApplication:(SBApplication*)application orientation:(int)orientation loadAsync:(BOOL)async withQueue:(id)queue statusBarCache:(id)cache
{
    if(active && blurDisabledApps)
    {
        NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:SETTINGS_FILE2];
        if (![[prefs objectForKey:[application bundleIdentifier]] boolValue]) // disabled app
        {
            UIImageView *snapshot = (UIImageView *) %orig();
            CAFilter *filter = [CAFilter filterWithName:@"gaussianBlur"];
            [filter setValue:@10 forKey:@"inputRadius"];
            snapshot.layer.filters = [NSArray arrayWithObject:filter];
            return snapshot;
        }
    }

    return %orig;
}

%end

%ctor
{
    CFNotificationCenterRef r = CFNotificationCenterGetDarwinNotifyCenter();
    CFNotificationCenterAddObserver(r, NULL, &reloadSettings, CFSTR("com.efrederickson.guestframework/reloadSettings"), NULL, 0);
    reloadSettings(NULL, NULL, NULL, NULL, NULL);
}
