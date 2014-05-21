#import <LibGuest/LibGuest.h>
#import <UIKit/UIScrollView.h>

@interface SBSearchScrollView : UIScrollView
-(BOOL)gestureRecognizerShouldBegin:(id)arg1 ;
-(BOOL)_canScrollY;
@end

SBSearchScrollView *search;

@interface SpotlightPluginPlugin : NSObject <LGPlugin>
@end

@implementation SpotlightPluginPlugin

-(void) activate
{
    [search setScrollEnabled:NO];
}

-(void) deactivate
{
    [search setScrollEnabled:YES];
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
%end