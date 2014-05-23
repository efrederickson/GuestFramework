#import <UIKit/UIKit.h>
#import <Preferences/Preferences.h>
#import <LibGuest/LibGuest.h>

@interface LGPluginsController2 : PSTableCell <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
}

@end