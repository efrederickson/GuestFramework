#import <LibGuest/LibGuest.h>

BOOL active = NO;

@interface SiriPlugin : NSObject <LGPlugin>
@end

@implementation SiriPlugin

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
    return @"Siri";
}
-(NSString*) author
{
    return @"Elijah Frederickson";
}

-(NSString*)uniqueIdentifier
{
    return @"com.efrederickson.guestframework.plugins.siri";
}

@end

%hook SBAssistantController
+(BOOL)shouldEnterAssistant
{
    if (active)
        return NO;
        
    return %orig;
}
%end