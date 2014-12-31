//
//  DataBaseManager.m
//  Tada
//
//  Created by Ed on 2014/12/24.
//  Copyright (c) 2014年 cloudonline. All rights reserved.
//

#import "DataBaseManager.h"

DataBaseManager *_dbManager;


@implementation DataBaseManager

+ (DataBaseManager *)sharedDBManager
{
    @synchronized(self) {
        if (!_dbManager) {
            _dbManager = [[self alloc] init];
        }
    }
    return _dbManager;
}

- (id)init {
    if ((self = [super init])) {
        [self createDB];
        
        
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
        [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];

        
    }
    return self;
}

-(void)createDB{
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    // Build the path to the database file
    
    
    
    store_databasePath = [[NSString alloc] initWithString:
                         [docsDir stringByAppendingPathComponent: @"tada_store.sqlite3"]];
    
    place_databasePath = [[NSString alloc] initWithString:
                               [docsDir stringByAppendingPathComponent: @"tada_place.sqlite3"]];
    
    
    order_databasePath = [[NSString alloc] initWithString:
                         [docsDir stringByAppendingPathComponent: @"tada_order.sqlite3"]];
    
    
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    
    // store_table: store_name, store_address, isrecommend, isshow, build_time
    
    if ([filemgr fileExistsAtPath: store_databasePath ] == NO)
    {
        const char *dbpath = [store_databasePath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt ="create table if not exists store_table ( store_name text, store_address text, isrecommend BOOL, isshow BOOL, build_time DATETIME)";
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg)
                != SQLITE_OK)
            {
                NSLog(@"Failed to create table");
            }
            
            
            sqlite3_close(database);
            
        }
        else {
            NSLog(@"Failed to open/create database");
        }
        
        
    }
    
    
    
    // place_table : place_name, place_district, place_address, place_phone, place_note, isshow, build_time
    
    if ([filemgr fileExistsAtPath: place_databasePath ] == NO)
    {
        const char *dbpath = [place_databasePath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt ="create table if not exists place_table (place_name text, place_district text, place_address text, place_phone text, place_note text, isshow BOOL, build_time DATETIME)";
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg)
                != SQLITE_OK)
            {
                NSLog(@"Failed to create table");
            }
            

            sqlite3_close(database);
            
        }
        else {
            NSLog(@"Failed to open/create database");
        }
        
        
    }
    
    // order_table : order_id, order_status, items, storeName, storeAddress, placeName, placeDistrict, placeAddress, placePhone, placeNote,  order_fee, delivery_fee, tip, courier_Id, isshow, build_time,finish_time
    
    if ([filemgr fileExistsAtPath: order_databasePath ] == NO)
    {
        const char *dbpath = [order_databasePath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt ="create table if not exists order_table (order_id text, order_status text, items text, storeName text, storeAddress text, placeName text, placeDistrict text, placeAddress text, placePhone text, placeNote text, order_fee text, delivery_fee text, tip text, courier_Id text, isshow BOOL, build_time DATETIME, finish_time DATETIME)";
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg)
                != SQLITE_OK)
            {
                NSLog(@"Failed to create table");
            }
            
            
            
            
            sqlite3_close(database);
            
        }
        else {
            NSLog(@"Failed to open/create database");
        }
        
        
    }
    
    
}


-(void)addStore:(NSString*)storeName isRecommend:(BOOL)recommend{
    
    sqlite3_stmt *statement;
    const char *dbpath = [store_databasePath UTF8String];
    
    int isRecommend = [[NSNumber numberWithBool:recommend]intValue];
    NSString *build_time = [dateFormatter stringFromDate:[NSDate date]];

    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
    
        // store_table :store_id, store_name, store_address, isrecommend, isshow, build_time
        NSString *insertSQL =[NSString stringWithFormat:@"INSERT INTO store_table (store_name,store_address,isrecommend,isshow,build_time)values(\"%@\",\"%@\",\"%d\",\"%d\",\"%@\")",storeName,@"",isRecommend,1,build_time];

        
        const char *insert_stmt = [insertSQL UTF8String];
        
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        
        
        if (sqlite3_step(statement) != SQLITE_DONE){
            
            DLog(@"Extended SQLite message: %s", sqlite3_errmsg(database));
            
        }
        
        
        sqlite3_reset(statement);
    
    
    }else{
        DLog(@"Extended SQLite message: %s", sqlite3_errmsg(database));
    }





}

-(NSMutableArray *)storeArray{
    
    
    sqlite3_stmt *statement;
    const char *dbpath = [store_databasePath UTF8String];
    
    NSMutableArray *storeArray = [[NSMutableArray alloc] init];
    NSMutableArray *recommendStoreArray = [[NSMutableArray alloc] init];
    NSMutableArray *myStoreArray = [[NSMutableArray alloc] init];
    
    [storeArray addObject:recommendStoreArray];
    [storeArray addObject:myStoreArray];

    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        
        // store_table : store_name, store_address, isrecommend, isshow, build_time
        
        NSString *query = @"SELECT * FROM store_table ORDER BY rowid DESC";
        
        const char *query_stmt = [query UTF8String];
        
        sqlite3_prepare_v2(database, query_stmt,-1, &statement, NULL);
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            

            int isshowInt = sqlite3_column_int(statement, 3);
            
            BOOL isshow = isshowInt!=0;
            
            
            if (isshow) {
                
                char *store_nameChars = (char *) sqlite3_column_text(statement, 0);
                char *store_addressChars = (char *) sqlite3_column_text(statement, 1);
                int isrecommendInt = sqlite3_column_int(statement, 2);
            
                BOOL isrecommend = isrecommendInt!=0;
                
                NSString *store_name = store_nameChars == NULL ? nil : [[NSString alloc] initWithUTF8String:store_nameChars];
                NSString *store_address = store_addressChars == NULL ? nil : [[NSString alloc] initWithUTF8String:store_addressChars];

                
                NSMutableDictionary *storeDict = [[NSMutableDictionary alloc] init];
                
                [storeDict setObject:store_name forKey:@"store_name"];
                [storeDict setObject:store_address forKey:@"store_address"];
                
                if (isrecommend) {
                    [recommendStoreArray addObject:storeDict];
                }else{
                    [myStoreArray addObject:storeDict];
                }
                
            }

            
        }
        
        
        
        sqlite3_reset(statement);
        
    }
    
    
    
    return storeArray;


}



-(void)addPlace:(NSString*)placeName district:(NSString*)district address:(NSString*)address phoneNum:(NSString*)phoneNum note:(NSString*)note{


    sqlite3_stmt *statement;
    const char *dbpath = [place_databasePath UTF8String];
    
    NSString *build_time = [dateFormatter stringFromDate:[NSDate date]];
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        
        // place_table : place_name, place_district, place_address, place_phone, place_note, isshow, build_time

        NSString *insertSQL =[NSString stringWithFormat:@"INSERT INTO place_table (place_name,place_district,place_address,place_phone,place_note,isshow,build_time)values(\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%d\",\"%@\")",placeName,district,address,phoneNum,note,1,build_time];
        
        
        const char *insert_stmt = [insertSQL UTF8String];
        
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        
        
        if (sqlite3_step(statement) != SQLITE_DONE){
            
            DLog(@"Extended SQLite message: %s", sqlite3_errmsg(database));
            
        }
        
        
        sqlite3_reset(statement);
        
        
    }else{
        DLog(@"Extended SQLite message: %s", sqlite3_errmsg(database));
    }
    
    


}


-(NSMutableArray *)placeArray{

    sqlite3_stmt *statement;
    const char *dbpath = [place_databasePath UTF8String];
    
    NSMutableArray *placeArray = [[NSMutableArray alloc] init];

    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        
        // place_table : place_name, place_district, place_address, place_phone, place_note, isshow, build_time
        
        NSString *query = @"SELECT * FROM place_table ORDER BY rowid DESC";
        
        const char *query_stmt = [query UTF8String];
        
        sqlite3_prepare_v2(database, query_stmt,-1, &statement, NULL);
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            
            int isshowInt = sqlite3_column_int(statement, 5);
            
            BOOL isshow = isshowInt!=0;
            
            
            if (isshow) {
                
                char *place_nameChars = (char *) sqlite3_column_text(statement, 0);
                char *place_districtChars = (char *) sqlite3_column_text(statement, 1);

                char *place_addressChars = (char *) sqlite3_column_text(statement, 2);
                char *place_phoneChars = (char *) sqlite3_column_text(statement, 3);
                char *place_noteChars = (char *) sqlite3_column_text(statement, 4);
                
                
                NSString *place_name = place_nameChars == NULL ? nil : [[NSString alloc] initWithUTF8String:place_nameChars];
                NSString *place_district = place_districtChars == NULL ? nil : [[NSString alloc] initWithUTF8String:place_districtChars];
                NSString *place_address = place_addressChars == NULL ? nil : [[NSString alloc] initWithUTF8String:place_addressChars];
                NSString *place_phone = place_phoneChars == NULL ? nil : [[NSString alloc] initWithUTF8String:place_phoneChars];
                NSString *place_note = place_noteChars == NULL ? nil : [[NSString alloc] initWithUTF8String:place_noteChars];

                NSMutableDictionary *placeDict = [[NSMutableDictionary alloc] init];
                
                [placeDict setObject:place_name forKey:@"place_name"];
                [placeDict setObject:place_district forKey:@"place_district"];

                [placeDict setObject:place_address forKey:@"place_address"];
                [placeDict setObject:place_phone forKey:@"place_phone"];
                
                if (place_note) {
                    [placeDict setObject:place_note forKey:@"place_note"];

                }
                
                [placeArray addObject:placeDict];
                
            }
            
            
        }
        
        
        
        sqlite3_reset(statement);
        
    }
    
    
    
    return placeArray;


}



// order_table : order_id, order_status, items, storeName, storeAddress, placeName, placeDistrict, placeAddress, placePhone, placeNote,  order_fee, delivery_fee, tip, courier_Id, isshow, build_time,finish_time

//order_status:產生(start)，失敗(failure)，接受處理中(accept)，不接受(unaccept)，完成(finished)

// 新增 :items, storeName, placeName, placeDistrict, placeAddress, placePhone, placeNote
-(void)addOrder:(NSString*)items storeName:(NSString*)storeName placeName:(NSString*)placeName placeDistrict:(NSString*)placeDistrict placeAddress:(NSString*)placeAddress placePhone:(NSString*)placePhone placeNote:(NSString*)placeNote{

    sqlite3_stmt *statement;
    const char *dbpath = [order_databasePath UTF8String];
    
    
    NSString *build_time = [dateFormatter stringFromDate:[NSDate date]];
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        
        // 新增 :items, storeName, placeName, placeDistrict, placeAddress, placePhone, placeNote

        NSString *insertSQL =[NSString stringWithFormat:@"INSERT INTO order_table (items,storeName,placeName,placeDistrict,placeAddress,placePhone,placeNote,order_status,isshow,build_time)values(\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%d\",\"%@\")",items,storeName,placeName,placeDistrict,placeAddress,placePhone,placeNote,@"start",1,build_time];
        
        
        const char *insert_stmt = [insertSQL UTF8String];
        
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        
        
        if (sqlite3_step(statement) != SQLITE_DONE){
            
            DLog(@"Extended SQLite message: %s", sqlite3_errmsg(database));
            
        }
        
        
        sqlite3_reset(statement);
        
        
    }else{
        DLog(@"Extended SQLite message: %s", sqlite3_errmsg(database));
    }


}


// 更新：
//server 新增回應：rowid,order_id
//server order 狀態 notification ：order_id, order_status(接受或不接受)
//server 完成 notification ：order_id, order_status(完成)

-(void)updateOrder:(NSString*)rowid order_id:(NSString*)order_id order_status:(NSString*)order_status{




}

//order_id (option),order_status, items, storeName, placeName, build_time, finish_time(option)
-(NSMutableArray *)orderArray{

    sqlite3_stmt *statement;
    const char *dbpath = [order_databasePath UTF8String];
    
    NSMutableArray *orderArray = [[NSMutableArray alloc] init];
    
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        
    // order_table : order_id, order_status, items, storeName, storeAddress, placeName, placeDistrict, placeAddress, placePhone, placeNote,  order_fee, delivery_fee, tip, courier_Id, isshow, build_time,finish_time
        
        //order_status:產生(start)，失敗(failure)，接受處理中(accept)，不接受(unaccept)，完成(finished)
        
        
        NSString *query = @"SELECT * FROM order_table ORDER BY rowid DESC";
        
        const char *query_stmt = [query UTF8String];
        
        sqlite3_prepare_v2(database, query_stmt,-1, &statement, NULL);
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            
            int isshowInt = sqlite3_column_int(statement, 14);
            
            BOOL isshow = isshowInt!=0;
            
            
            if (isshow) {
                
                char *order_idChars = (char *) sqlite3_column_text(statement, 0);
                char *order_statusChars = (char *) sqlite3_column_text(statement, 1);
                char *itemsChars = (char *) sqlite3_column_text(statement, 2);
                char *storeNameChars = (char *) sqlite3_column_text(statement, 3);
                //char *storeAddressChars = (char *) sqlite3_column_text(statement, 4);
                char *placeNameChars = (char *) sqlite3_column_text(statement, 5);
                //char *placeDistrictChars = (char *) sqlite3_column_text(statement, 6);
                //char *placeAddressChars = (char *) sqlite3_column_text(statement, 7);
                //char *placePhoneChars = (char *) sqlite3_column_text(statement, 8);
                //char *placeNoteChars = (char *) sqlite3_column_text(statement, 9);
                //char *order_feeChars = (char *) sqlite3_column_text(statement, 10);
                //char *delivery_feeChars = (char *) sqlite3_column_text(statement, 11);
                //char *tipChars = (char *) sqlite3_column_text(statement, 12);
                //char *courier_IdChars = (char *) sqlite3_column_text(statement, 13);
                char *build_timeChars = (char *) sqlite3_column_text(statement, 15);
                char *finish_timeChars = (char *) sqlite3_column_text(statement, 16);

                
                NSString *order_id = order_idChars == NULL ? nil : [[NSString alloc] initWithUTF8String:order_idChars];
                NSString *order_status = order_statusChars == NULL ? nil : [[NSString alloc] initWithUTF8String:order_statusChars];
                NSString *items = itemsChars == NULL ? nil : [[NSString alloc] initWithUTF8String:itemsChars];
                NSString *storeName = storeNameChars == NULL ? nil : [[NSString alloc] initWithUTF8String:storeNameChars];
                NSString *placeName = placeNameChars == NULL ? nil : [[NSString alloc] initWithUTF8String:placeNameChars];
                NSString *build_time = build_timeChars == NULL ? nil : [[NSString alloc] initWithUTF8String:build_timeChars];
                NSString *finish_time = finish_timeChars == NULL ? nil : [[NSString alloc] initWithUTF8String:finish_timeChars];
                
                NSMutableDictionary *placeDict = [[NSMutableDictionary alloc] init];
                
                if (order_id) {
                    [placeDict setObject:order_id forKey:@"order_id"];
                }
                
                [placeDict setObject:order_status forKey:@"order_status"];
                [placeDict setObject:items forKey:@"items"];
                [placeDict setObject:storeName forKey:@"storeName"];
                [placeDict setObject:placeName forKey:@"placeName"];
                [placeDict setObject:build_time forKey:@"build_time"];
                
                if (finish_time) {
                    [placeDict setObject:order_id forKey:@"finish_time"];
                }
                
                [orderArray addObject:placeDict];
                
            }
            
            
        }
        
        
        
        sqlite3_reset(statement);
        
    }
    
    
    
    return orderArray;



}



@end
