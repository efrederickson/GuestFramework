#import "LGPluginsController.h"
#import "LGSwitchCell.h"
#import <LibGuest/LibGuest.h>
#import <Preferences/Preferences.h>
#import <objc/runtime.h>
#import "LGPluginSettingsPanel.h"
#import "LGPluginSubPanel.h"

@interface PSViewController (LibGuest)
-(UINavigationController*)navigationController;
@end

@implementation LGPluginsController
-(id) initForContentSize:(CGSize)size
{
	if ((self = [super initForContentSize:size]))
    {
        [self initTableView:size];
	}
	return self;
}

-(void) initTableView:(CGSize)size
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height) style:UITableViewStyleGrouped];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    [_tableView setEditing:NO];
    [_tableView setAllowsSelection:YES];
    
    if ([self respondsToSelector:@selector(setView:)])
        [self performSelectorOnMainThread:@selector(setView:) withObject:_tableView waitUntilDone:YES];
}

- (id)view
{
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[LibGuest sharedInstance]->delegates count];
}

-(id)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id cell = [tableView dequeueReusableCellWithIdentifier:@"PluginCell"];
    
    id<LGPlugin> plugin = [[LibGuest sharedInstance]->delegates objectAtIndex:[indexPath row]];
    if ([plugin respondsToSelector:@selector(preferenceSpecifiers)] && plugin.preferenceSpecifiers != nil)
    {
        if (!cell)
            cell = [[LGPluginSettingsPanel alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PluginCell"];
        ((LGPluginSettingsPanel*)cell).plugin = plugin;
        ((LGPluginSettingsPanel*)cell).textLabel.text = [plugin pluginName];
    }
    else
    {
        if (!cell)
        {
            cell = [[LGSwitchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PluginCell"];
        }
        ((LGSwitchCell*)cell).plugin = plugin;
        ((LGSwitchCell*)cell).textLabel.text = [plugin pluginName];
        [((LGSwitchCell*)cell) checkValue];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id cell = [tableView cellForRowAtIndexPath:indexPath];
    id<LGPlugin> plugin = [[LibGuest sharedInstance]->delegates objectAtIndex:[indexPath row]];
    if ([cell isKindOfClass:[LGPluginSettingsPanel class]])
    {
        //id pSpecs = [plugin preferenceSpecifiers];
        
        //UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
        
        // Need to mimic what PSListController does when it handles didSelectRowAtIndexPath
        // otherwise the child controller won't load
        LGPluginSubPanel* controller = [[LGPluginSubPanel alloc]
                                        initWithPlugin:plugin];
        
        controller.rootController = self.rootController;
        controller.parentController = self;	
        
        [self pushController:controller];
        [tableView deselectRowAtIndexPath:indexPath animated:true];
    }
}
@end

#define WBSAddMethod(_class, _sel, _imp, _type) \
if (![[_class class] instancesRespondToSelector:@selector(_sel)]) \
class_addMethod([_class class], @selector(_sel), (IMP)_imp, _type)

id $PSViewController$initForContentSize$(PSRootController *self, SEL _cmd, CGRect contentSize) {
    return [self init];
}
static __attribute__((constructor)) void __wbsInit() {
    WBSAddMethod(PSViewController, initForContentSize:, $PSViewController$initForContentSize$, "@@:{ff}");
}
