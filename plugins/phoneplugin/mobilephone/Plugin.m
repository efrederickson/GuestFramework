#import <LibGuest/LibGuest.h>
#import <notify.h>

@interface MobilePhonePlugin : NSObject <LGPlugin>
@end

@implementation MobilePhonePlugin

-(void) activate
{
    notify_post("com.efrederickson.guestframework.plugins.phoneapp/activate");
}

-(void) deactivate
{
    notify_post("com.efrederickson.guestframework.plugins.phoneapp/deactivate");
}

-(NSString*) pluginName
{
    return @"Phone dialer tab only";
}
-(NSString*) author
{
    return @"Elijah Frederickson";
}

-(NSString*)uniqueIdentifier
{
    return @"com.efrederickson.guestframeworks.plugins.phoneapp";
}

@end
