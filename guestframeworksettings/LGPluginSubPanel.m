#import "LGPluginSubPanel.h"
#import <Preferences/Preferences.h>
#import <LibGuest/LibGuest.h>

@interface PSListController (LibGuest)
-(void)viewDidLoad;
@end

@implementation LGPluginSubPanel
-(id) initWithPlugin:(id<LGPlugin>)plugin_
{
    plugin = plugin_;
    return [self init];
}

-(id) init
{
    self = [super init];
    return self;
}

-(void)viewDidLoad
{
	[super viewDidLoad];
	[self setTitle:plugin.pluginName];
}

-(id)specifiers
{
	if (_specifiers) return _specifiers;
    
	_specifiers = [[NSMutableArray alloc] init];
    
    PSSpecifier *specifier = [PSSpecifier preferenceSpecifierNamed:@"Enabled" target:self set:@selector(setValue:specifier:) get:@selector(getValue:) detail:nil cell:PSSwitchCell edit:nil];
    [(NSMutableArray*)_specifiers addObject:specifier];
    
    specifier = [PSSpecifier preferenceSpecifierNamed:@"" target:self set:nil get:nil detail:nil cell:PSGroupCell edit:nil];
    [(NSMutableArray*)_specifiers addObject:specifier];
    
    [(NSMutableArray*)_specifiers addObjectsFromArray:[plugin preferenceSpecifiers]];
    
	return _specifiers;
}

-(void) setValue:(NSNumber*)value specifier:(PSSpecifier*)sender
{
    if ([value boolValue])
        [[LibGuest sharedInstance] enablePlugin:plugin];
    else
        [[LibGuest sharedInstance] disablePlugin:plugin];
}

-(NSNumber*) getValue:(PSSpecifier*)sender
{
    return [NSNumber numberWithBool:[[LibGuest sharedInstance] isPluginEnabled:plugin]];
}
@end