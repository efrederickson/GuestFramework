#import "LGPluginsController2.h"
#import "LGSwitchCell.h"
#import <LibGuest/LibGuest.h>
#import <Preferences/Preferences.h>
#import <objc/runtime.h>
#import "LGPluginSettingsPanel.h"
#import "LGPluginSubPanel.h"
#import "GuestFrameworkSettings.h"

@interface PSViewController (LibGuest)
-(UINavigationController*)navigationController;
@end
@interface PSTableCell (LibGuest)
@property (nonatomic, retain) UIView *backgroundView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end

@implementation LGPluginsController2

-(void)layoutSubviews
{
    _tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStyleGrouped];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    [_tableView setEditing:NO];
    [_tableView setAllowsSelection:YES];
    _tableView.scrollEnabled = NO;
    
    _tableView.frame = CGRectMake(0, 0, [self frame].size.width, [self frame].size.height);
    
    if ([self respondsToSelector:@selector(setView:)])
        [self performSelectorOnMainThread:@selector(setView:) withObject:_tableView waitUntilDone:YES];
    
    [self addSubview:_tableView];
    
}

- (void)resizeTableViewFrameHeight
{
    UITableView *tableView = _tableView;
    CGRect frame = tableView.frame;
    frame.size.height = [tableView sizeThatFits:CGSizeMake(frame.size.width, HUGE_VALF)].height;
    tableView.frame = frame;
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
    
    if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row)
    {
        [self resizeTableViewFrameHeight];
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, _tableView.frame.size.width, _tableView.frame.size.height);
        [[GuestFrameworkSettingsListController sharedController] setPluginCellHeight:_tableView.frame.size.height];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id cell = [tableView cellForRowAtIndexPath:indexPath];
    id<LGPlugin> plugin = [[LibGuest sharedInstance]->delegates objectAtIndex:[indexPath row]];
    if ([cell isKindOfClass:[LGPluginSettingsPanel class]])
    {
        GuestFrameworkSettingsListController *parent = [GuestFrameworkSettingsListController sharedController];
        
        // Need to mimic what PSListController does when it handles didSelectRowAtIndexPath
        // otherwise the child controller won't load
        LGPluginSubPanel* controller = [[LGPluginSubPanel alloc]
                                        initWithPlugin:plugin];
        
        controller.rootController = parent.rootController;
        controller.parentController = parent;
        
        [parent pushController:controller];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

@end
