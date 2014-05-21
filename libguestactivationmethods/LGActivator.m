#import "LGActivator.h"
#import <libactivator/libactivator.h>
#import <LibGuest/LibGuest.h>

@implementation LGActivator
- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event
{
    // Activate your plugin
    [[LibGuest sharedInstance] activate];
    
	[event setHandled:YES]; // To prevent the default OS implementation
}

- (void)activator:(LAActivator *)activator abortEvent:(LAEvent *)event
{
    // Dismiss
}

+ (void)load
{
	if ([LASharedActivator isRunningInsideSpringBoard]) {
        // Wow, ARC. thanks a lot for this mess.
        // the __bridge_retained makes it so the new self does not autorelease (crashing SpringBoard)
        // and the (__bridge id) casts it back into a proper object for Activator
        void* obj = (__bridge_retained void*)[self new];
		[LASharedActivator registerListener:(__bridge id)obj forName:@"com.efrederickson.guestframework.activationmethods.activator"];
	}
}

@end