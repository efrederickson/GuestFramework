#import <LibGuest/LibGuest.h>
#import <UIKit/UIKit.h>

@interface sample_plugin : NSObject <LGPlugin>
@end

@implementation sample_plugin

-(void) activate
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"GuestFramework" message:@"GuestFramework Activated" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

-(void) deactivate
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"GuestFramework" message:@"GuestFramework Deactivated" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

-(NSString*) pluginName
{
    return @"Sample Plugin";
}
-(NSString*) author
{
    return @"Elijah Frederickson";
}
-(NSString*)uniqueIdentifier
{
    return @"com.efrederickson.guestframework.sample_plugin";
}

@end