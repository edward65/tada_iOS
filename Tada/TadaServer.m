//
//  TadaServer.m
//  Tada
//
//  Created by Ed on 2014/12/26.
//  Copyright (c) 2014年 cloudonline. All rights reserved.
//

#import "TadaServer.h"

@implementation TadaServer

static TadaServer *_sharedServer;

+ (TadaServer *)sharedServer
{
    @synchronized(self) {
        
        if (!_sharedServer) {
            
            _sharedServer = [[self alloc] init];

        }
        
        return _sharedServer;
    }
    
}


#pragma mark ServerDataAPI

//服務區域：兩層:1.國家(dic) 2.地區(array)
- (void)serviceDistrict:(id <ServerDataDelegate>)delegate{
    


}



#pragma mark LoginAPI

- (void)phoneVerifyCode:(id <LoginDelegate>)delegate code:(NSString*)code{
}



- (void)sendPhoneNum:(id <LoginDelegate>)delegate phoneNum:(NSString*)phoneNum{

}


@end
