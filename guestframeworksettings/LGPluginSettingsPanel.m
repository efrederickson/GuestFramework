#import "LGPluginSettingsPanel.h"

@implementation LGPluginSettingsPanel

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if ((self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier])) {
		self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	return self;
}

@end