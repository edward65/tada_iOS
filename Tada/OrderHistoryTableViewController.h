//
//  OrderHistoryTableViewController.h
//  Tada
//
//  Created by Ed on 2014/12/31.
//  Copyright (c) 2014年 cloudonline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataBaseManager.h"
#import "OrderProcessViewController.h"

@interface OrderHistoryTableViewController : UITableViewController{

    Config *config;
    DataBaseManager *dataBaseManager;
    
    NSMutableArray *orderArray;

}

@end
