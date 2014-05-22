#import <LibGuest/LibGuest.h>

BOOL active = NO;

@interface @@PROJECTNAME@@Plugin : NSObject <LGPlugin>
@end

@implementation @@PROJECTNAME@@Plugin

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
    return @"@@PROJECTNAME@@";
}
-(NSString*) author
{
    return @"@@USER@@";
}

-(NSString*)uniqueIdentifier
{
    return @"@@PACKAGENAME@@";
}

@end

// Put your theos hooks here

