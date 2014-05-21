#import <LibPass/LibPass.h>

@protocol LGPlugin <NSObject>
-(void) activate;
-(void) deactivate;

-(NSString*) pluginName;
-(NSString*) author;
-(NSString*) uniqueIdentifier;
@end

@interface LibGuest : NSObject
{
    @public
    NSMutableArray *delegates;
    @private
    BOOL _isActive;
}

+(instancetype) sharedInstance;

-(void) registerPlugin:(id<LGPlugin>)plugin;
-(void) deregisterPlugin:(id<LGPlugin>)plugin;

-(void) loadPlugins;
-(void) reloadPlugins;

-(BOOL) isActive;
-(void) activate;
-(void) deactivate;

-(BOOL) isPluginEnabled:(id<LGPlugin>)plugin;
-(void) enablePlugin:(id<LGPlugin>)plugin;
-(void) disablePlugin:(id<LGPlugin>)plugin;
@end