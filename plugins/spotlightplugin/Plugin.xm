#import <LibGuest/LibGuest.h>
#import <UIKit/UIScrollView.h>

@interface SBSearchScrollView : UIScrollView
-(BOOL)gestureRecognizerShouldBegin:(id)arg1 ;
-(BOOL)_canScrollY;
@end

SBSearchScrollView *search;
BOOL active = NO;

@interface SpotlightPluginPlugin : NSObject <LGPlugin>
@end

@implementation SpotlightPluginPlugin

-(void) activate
{
    [search setScrollEnabled:NO];
    active = YES;
}

-(void) deactivate
{
    [search setScrollEnabled:YES];
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
-(id) init
{
    id x = %orig;
    search = x;
    return x;
}
-(BOOL)gestureRecognizerShouldBegin:(id)arg1
{
    if (active)
        return NO;
    return %orig;
}
%end