//
//  OiGATracker.m
//  Oi
//
//  Created by Ed on 2014/10/9.
//  Copyright (c) 2014年 Hsiang-Lin Yeh. All rights reserved.
//

#import "TadaGATracker.h"

static const NSInteger kDefaultDispatchPeriod = 20;
static TadaGATracker *sSharedTracker = nil;


@implementation TadaGATracker


+(TadaGATracker *)sharedTracker {
    
    @synchronized(self) {
        
        if (sSharedTracker == nil) {
            
            sSharedTracker = [[self alloc] init];
            
        }
        
        return sSharedTracker;
        
    }
    
}

- (id)init
{
    self = [super init];
    
    if (self) {
        
        // Optional: automatically send uncaught exceptions to Google Analytics.
        [GAI sharedInstance].trackUncaughtExceptions = YES;
        
        // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
        [GAI sharedInstance].dispatchInterval = kDefaultDispatchPeriod;
        
        // Optional: set Logger to VERBOSE for debug information.   
        //[[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
        
        // Initialize tracker. Replace with your tracking ID.
        [[GAI sharedInstance] trackerWithTrackingId:@"UA-49489068-2"];
        
        
        tracker = [[GAI sharedInstance] defaultTracker];
        
        
    }
    
    return self;
}



-(void)trackMyPage:(NSString*)page{
    
    
    [tracker set:kGAIScreenName value:page];
    
    [tracker send:[[GAIDictionaryBuilder createAppView]  build]];
    
}



-(void)trackMyEvent:(NSString *)my_category
             action:(NSString *)my_action
              lable:(NSString *)my_label
{
    
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:my_category     // Event category (required)
                                                          action:my_action  // Event action (required)
                                                           label:@""            // Event label
                                                           value:nil] build]];    // Event value
    
    
}


@end


