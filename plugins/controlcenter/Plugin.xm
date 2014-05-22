#import <LibGuest/LibGuest.h>

BOOL active = NO;

@interface ControlCenterPlugin : NSObject <LGPlugin>
@end

@implementation ControlCenterPlugin

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
    return @"Control Center";
}
-(NSString*) author
{
    return @"Elijah Frederickson";
}

-(NSString*)uniqueIdentifier
{
    return @"com.efrederickson.guestframework.plugins.controlcenter";
}

@end

%hook SBUIController
-(void)handleShowControlCenterSystemGesture:(id)gesture
{
    if (active)
        return;
        
    %orig;
}
%end