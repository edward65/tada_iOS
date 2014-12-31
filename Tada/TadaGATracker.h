//
//  OiGATracker.h
//  Oi
//
//  Created by Ed on 2014/10/9.
//  Copyright (c) 2014年 Hsiang-Lin Yeh. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"


@interface TadaGATracker : NSObject{
    
    id <GAITracker> tracker;
    
}

+ (TadaGATracker *)sharedTracker;

-(void)trackMyPage:(NSString*)page;

-(void)trackMyEvent:(NSString*)my_category
             action:(NSString*)my_action
              lable:(NSString*)my_label;

@end
