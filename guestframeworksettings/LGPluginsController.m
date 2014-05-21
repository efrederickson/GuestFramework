#import "LGPluginsController.h"
#import "LGSwitchCell.h"
#import <LibGuest/LibGuest.h>
#import <Preferences/Preferences.h>
#import <objc/runtime.h>

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
    [_tableView setAllowsSelection:NO];
    
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
    LGSwitchCell *cell = (LGSwitchCell*)[tableView dequeueReusableCellWithIdentifier:@"PluginCell"];
    if (!cell)
    {
        cell = [[LGSwitchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PluginCell"];
    }
    
    id<LGPlugin> plugin = [[LibGuest sharedInstance]->delegates objectAtIndex:[indexPath row]];
    cell.plugin = plugin;
    cell.textLabel.text = [plugin pluginName];
    [cell checkValue];
    
    return cell;
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
