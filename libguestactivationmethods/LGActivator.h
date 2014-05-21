#import <libactivator/libactivator.h>

@interface LGActivator : NSObject<LAListener>
- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event;
- (void)activator:(LAActivator *)activator abortEvent:(LAEvent *)event;
@end