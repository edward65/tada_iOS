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
NSString *TADA_SERVER_URL;


+ (TadaServer *)sharedServer
{
    @synchronized(self) {
        
        if (!_sharedServer) {
            
            TADA_SERVER_URL = [NSString stringWithFormat:@"%@/api/%@", [[Config sharedInstance] TADA_SERVER], [[Config sharedInstance] api_version]];
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



//Edward test API

//get idea
- (void)getIdea{
    
    NSLog(@"Edward =000==11= getIdea");


    
    
    NSString *URLString = @"http://shielded-lowlands-6926.herokuapp.com/ideas/1.json";
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Edward ===11===JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Edward ====11====Error: %@", error);
        
    }];


}


//post idea
- (void)postIdea{
    
    
    
    
    NSDictionary *parameters=@{ @"name": @"idea2",
                                @"description": @"idea 222",

                                
                                };

    NSString *URLString = @"http://shielded-lowlands-6926.herokuapp.com/ideas/1";
    
    NSLog(@"Edward =000==22= postIdea");


    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager PUT:URLString
       parameters:@{@"name": @"idea2"}
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"Edward ===22===JSON: %@", responseObject);
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Edward ====22====Error: %@", error);
          }];

}



//addOrder
- (void)addOrder:(NSString*)items storeName:(NSString *)storeName receivePlace:(NSString *)receivePlace receiveAddress:(NSString *)receiveAddress receivePhone:(NSString *)receivePhone receiveNote:(NSString *)receiveNote{

    
    NSDictionary *parameters=@{ @"user_id": @"1",
                                @"store_name": storeName,
                                @"items": items,
                                @"receive_place": receivePlace,
                                @"receive_address": receiveAddress,
                                @"receive_phone": receivePhone,
                                @"receive_note": receiveNote,

                                };
    
    NSString *URLString = [NSString stringWithFormat:@"%@/add_order.json", TADA_SERVER_URL];
    
    AFSecurityPolicy *policy = [[AFSecurityPolicy alloc] init];
    [policy setAllowInvalidCertificates:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setSecurityPolicy:policy];
    
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    [manager POST:URLString
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"Edward ===22===JSON: %@", responseObject);
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Edward ====22====Error: %@", error);
         }];
    
}


@end
