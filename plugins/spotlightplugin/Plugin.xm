#import <LibGuest/LibGuest.h>
#import <UIKit/UIScrollView.h>

BOOL active = NO;

@interface SpotlightPlugin : NSObject <LGPlugin>
@end

@implementation SpotlightPlugin

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
    return @"Spotlight";
}
-(NSString*) author
{
    return @"Elijah Frederickson";
}
-(NSString*)uniqueIdentifier
{
    return @"com.efrederickson.guestframework.plugins.spotlight";
}

@end

%hook SBSearchScrollView
-(BOOL)gestureRecognizerShouldBegin:(id)arg1
{
    if (active)
        return NO;
    return %orig;
}
%end