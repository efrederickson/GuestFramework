#import <LibPass/LibPass.h>

@interface LGLibPassDelegate : NSObject <LibPassDelegate>
{
    // This is used to activate libGuest
    NSString *lastPassword;
}
@end
