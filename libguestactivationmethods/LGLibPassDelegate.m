#import "LGLibPassDelegate.h"
#import <LibGuest/LGSettings.h>
#import <LibGuest/LibGuest.h>
#import <LibPass/LibPass.h>

#define SETTINGS [LGSettings sharedInstance]

@implementation LGLibPassDelegate
-(void)passwordWasEntered:(NSString*)password
{
    if ([[LibPass sharedInstance] shouldAllowPasscode:password])
        return;
    
    if (SETTINGS.acceptAnyPassword)
    {
        [[LibGuest sharedInstance] activate];
    }
    else if (SETTINGS.acceptCertainPassword && [SETTINGS.guestPasscode isEqualToString:password])
    {
        [[LibGuest sharedInstance] activate];
    }
}
@end
