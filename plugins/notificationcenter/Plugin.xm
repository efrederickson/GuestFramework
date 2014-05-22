#import <LibGuest/LibGuest.h>

BOOL active = NO;

@interface NotificationCenterPlugin : NSObject <LGPlugin>
@end

@implementation NotificationCenterPlugin

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
    return @"Notification Center";
}
-(NSString*) author
{
    return @"Elijah Frederickson";
}

-(NSString*)uniqueIdentifier
{
    return @"com.efrederickson.guestframework.plugins.notificationcenter";
}

@end
