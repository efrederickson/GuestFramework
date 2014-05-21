#import <LibGuest/LibGuest.h>
#import "LGLibPassDelegate.h"
#import <dlfcn.h>

%ctor
{
    dlopen("/Library/MobileSubstrate/DynamicLibraries/libGuest.dylib", RTLD_NOW | RTLD_GLOBAL);
    dlopen("/Library/MobileSubstrate/DynamicLibraries/libPass.dylib", RTLD_NOW | RTLD_GLOBAL);
    [[LibPass sharedInstance] registerDelegate:[[LGLibPassDelegate alloc] init]];

}