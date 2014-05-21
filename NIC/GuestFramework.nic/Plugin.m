#import <LibGuest/LibGuest.h>

@interface @@PROJECTNAME@@Plugin : NSObject <LGPlugin>
@end

@implementation @@PROJECTNAME@@Plugin

-(void) activate
{
    
}

-(void) deactivate
{
    
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