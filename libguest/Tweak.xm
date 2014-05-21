#import "LibGuest.h"
#import <dlfcn.h>
#import "LGSettings.h"

@interface SBLockStateAggregator
+(id)sharedInstance;
-(void)_updateLockState;
-(BOOL)hasAnyLockState;
@end

static void reloadSettings(CFNotificationCenterRef center,
                                    void *observer,
                                    CFStringRef name,
                                    const void *object,
                                    CFDictionaryRef userInfo)
{
    [[LGSettings sharedInstance] reloadSettings];
}

%hook SBLockStateAggregator
-(void)_updateLockState
{
    %orig;
    
    if ([self hasAnyLockState]) // it is locked
        if ([[LibGuest sharedInstance] isActive] && ![[LibPass sharedInstance] toggleValue]) // GuestFramework is active, and the device is not unlocking via LibPass
            [[LibGuest sharedInstance] deactivate];
}
%end

%ctor
{
    dlopen("/Library/MobileSubstrate/DynamicLibraries/libPass.dylib", RTLD_NOW | RTLD_GLOBAL);

    [[LibGuest sharedInstance] loadPlugins];

    CFNotificationCenterRef r = CFNotificationCenterGetDarwinNotifyCenter();
    CFNotificationCenterAddObserver(r, NULL, &reloadSettings, CFSTR("com.efrederickson.guestframework/reloadSettings"), NULL, 0);
}