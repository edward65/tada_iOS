//
//  TadaServer.h
//  Tada
//
//  Created by Ed on 2014/12/26.
//  Copyright (c) 2014年 cloudonline. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


@protocol ServerDataDelegate <NSObject>

- (void)phoneVerifyCodeResponse:(id)json;
- (void)sendPhoneNumResponse:(id)json;

@end


@protocol LoginDelegate <NSObject>

- (void)phoneVerifyCodeResponse:(id)json;
- (void)sendPhoneNumResponse:(id)json;

@end



@interface TadaServer : NSObject{




}

+ (TadaServer *)sharedServer;


//ServerDataAPI
- (void)serviceDistrict:(id <ServerDataDelegate>)delegate;



//loaginAPI
- (void)phoneVerifyCode:(id <LoginDelegate>)delegate code:(NSString*)code;
- (void)sendPhoneNum:(id <LoginDelegate>)delegate phoneNum:(NSString*)phoneNum;


//order API
// order API: userId,items, storeName, placeName, placeDistrict, placeAddress, placePhone, placeNote
//回應：order_id  (rowid 自己帶) 或網路失敗 -->order_status(failure)



//Edward test API

//get idea
- (void)getIdea;


//post idea
- (void)postIdea;


//order
- (void)addOrder:(NSString*)items storeName:(NSString *)storeName receivePlace:(NSString *)receivePlace receiveAddress:(NSString *)receiveAddress receivePhone:(NSString *)receivePhone receiveNote:(NSString *)receiveNote;



@end
