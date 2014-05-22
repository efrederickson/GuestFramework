#import <LibGuest/LibGuest.h>

BOOL active = NO;

@interface NewsStandPlugin : NSObject <LGPlugin>
@end

@implementation NewsStandPlugin

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
    return @"NewsStand";
}
-(NSString*) author
{
    return @"Elijah Frederickson";
}

-(NSString*)uniqueIdentifier
{
    return @"com.efrederickson.guestframework.plugins.newsstand";
}

@end

%hook SBNewsstandIcon
-(void)launchFromLocation:(int)location
{
    if (active)
        return;

    %orig;
}
%end