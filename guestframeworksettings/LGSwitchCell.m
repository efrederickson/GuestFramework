#import "LGSwitchCell.h"

@implementation LGSwitchCell
@synthesize switchView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
		switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
		[switchView addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventValueChanged];
		[self setAccessoryView:switchView];
	}
	return self;
}

-(void) checkValue
{
    switchView.on = [[LibGuest sharedInstance] isPluginEnabled:self.plugin];
}

- (void)valueChanged
{
	BOOL toggle = switchView.on;
    if (toggle)
        [[LibGuest sharedInstance] enablePlugin:self.plugin];
    else
        [[LibGuest sharedInstance] disablePlugin:self.plugin];
}

@end