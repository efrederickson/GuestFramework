#import <LibGuest/LibGuest.h>
#import <Preferences/Preferences.h>
#define SETTINGS_FILE @"/var/mobile/Library/Preferences/com.efrederickson.guestframework.plugins.iconrestrictor.plist"

@interface SBIcon
-(void)launchFromLocation:(int)arg1;
-(id)leafIdentifier;
-(id)nodeIdentifier;
@end

@interface SBApplicationIcon : SBIcon
@end

BOOL active = NO;

@interface IconRestrictorPlugin : PSListController <LGPlugin>
@end

@implementation IconRestrictorPlugin

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
    return @"App Restrictor";
}
-(NSString*) author
{
    return @"Elijah Frederickson";
}

-(NSString*)uniqueIdentifier
{
    return @"com.efrederickson.guestframework.plugins.iconrestrictor";
}

-(id) preferenceSpecifiers
{
    return [self loadSpecifiersFromPlistName:@"IconRestrictorPlugin" target:self];
}
@end

%hook SBApplicationIcon
-(void)launchFromLocation:(int)arg1
{
    if (active)
    {
        NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:SETTINGS_FILE];
        if (![[prefs objectForKey:[self leafIdentifier]] boolValue])
            return;
    }

    %orig;
}

/*
-(BOOL)launchEnabled
{
    if (active)
    {
        NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:SETTINGS_FILE];
        if (![[prefs objectForKey:[self leafIdentifier]] boolValue])
            return NO;
    }

    return %orig;
}
*/

%end