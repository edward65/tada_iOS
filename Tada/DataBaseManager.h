//
//  DataBaseManager.h
//  Tada
//
//  Created by Ed on 2014/12/24.
//  Copyright (c) 2014年 cloudonline. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <sqlite3.h>

@interface DataBaseManager : NSObject{

    sqlite3* database;
    
    NSString *store_databasePath;
    NSString *place_databasePath;
    NSString *order_databasePath;

    NSDateFormatter *dateFormatter;


}

+ (DataBaseManager *)sharedDBManager;



-(void)addStore:(NSString*)storeName isRecommend:(BOOL)recommend;
-(NSMutableArray *)storeArray;


-(void)addPlace:(NSString*)placeName district:(NSString*)district address:(NSString*)address phoneNum:(NSString*)phoneNum note:(NSString*)note;
-(NSMutableArray *)placeArray;



// order_table : order_id, order_status, items, storeName, storeAddress, placeName, placeDistrict, placeAddress, placePhone, placeNote, isshow, order_fee, delivery_fee, tip, courier_Id, build_time,finish_time

//order_status:產生(start)，失敗(failure)，接受處理中(accept)，不接受(unaccept)，完成(finished)



// 新增 :items, storeName, placeName, placeDistrict, placeAddress, placePhone, placeNote
-(void)addOrder:(NSString*)items storeName:(NSString*)storeName placeName:(NSString*)placeName placeDistrict:(NSString*)placeDistrict placeAddress:(NSString*)placeAddress placePhone:(NSString*)placePhone placeNote:(NSString*)placeNote;


// 更新：

//server 新增回應：rowid,order_id  或網路失敗 -->order_status(failure)
//server order 狀態 notification ：order_id, order_status(接受或不接受)
//server 完成 notification ：order_id, order_status(完成)

-(void)updateOrder:(NSString*)rowid order_id:(NSString*)order_id order_status:(NSString*)order_status;


//order_id (option),order_status, items, storeName, placeName, build_time, finish_time(option)
-(NSMutableArray *)orderArray;


@end
