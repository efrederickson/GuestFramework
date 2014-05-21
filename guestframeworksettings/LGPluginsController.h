#import <UIKit/UIKit.h>
#import <Preferences/Preferences.h>
#import <LibGuest/LibGuest.h>

@interface LGPluginsController : PSViewController <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
}

- (id)initForContentSize:(CGSize)size;
- (id)view;
@end