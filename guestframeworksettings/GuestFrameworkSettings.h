@interface GuestFrameworkSettingsListController : PSListController { }
+(instancetype) sharedController;

-(void) setPluginCellHeight:(CGFloat)height;
@end