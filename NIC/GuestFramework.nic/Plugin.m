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
    return @"@@PLUGINNAME@@";
}
-(NSString*) author
{
    return @"@@USER@@";
}

@end