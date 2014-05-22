#import <notify.h>

@interface PhoneTabBarController
-(void)switchToTab:(int)arg1 ;
-(void)showFavoritesTab:(BOOL)arg1 recentsTab:(BOOL)arg2 contactsTab:(BOOL)arg3 keypadTab:(BOOL)arg4 voicemailTab:(BOOL)arg5;

-(id)favoritesViewController;
-(id)recentsViewController;
-(id)contactsViewController;
-(id)keypadViewController;
-(id)voicemailViewController;
@end

BOOL enable = NO;
PhoneTabBarController *PTBC;

void activate(CFNotificationCenterRef center,
                                    void *observer,
                                    CFStringRef name,
                                    const void *object,
                                    CFDictionaryRef userInfo)
{
    [PTBC switchToTab:4];
    enable = YES;
}

void deactivate(CFNotificationCenterRef center,
                                    void *observer,
                                    CFStringRef name,
                                    const void *object,
                                    CFDictionaryRef userInfo)
{
    enable = NO;
}

%hook PhoneTabBarController

-(id) init
{
    id x = %orig;
    PTBC = x;
    return x;
}
-(void)setSelectedViewController:(id)arg1 
{
    if (enable)
        return;
        
    %orig;
}
%end

%ctor
{
    CFNotificationCenterRef r = CFNotificationCenterGetDarwinNotifyCenter();
    CFNotificationCenterAddObserver(r, NULL, &activate, CFSTR("com.efrederickson.guestframework.plugins.phoneapp/activate"), NULL, 0);
    CFNotificationCenterAddObserver(r, NULL, &deactivate, CFSTR("com.efrederickson.guestframework.plugins.phoneapp/deactivate"), NULL, 0);
}



