//
//  OrderFromViewController.h
//  Tada
//
//  Created by Ed on 2014/12/16.
//  Copyright (c) 2014年 cloudonline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataBaseManager.h"



@interface OrderFromViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{

    Config *config;
    DataBaseManager *dataBaseManager;
    int sectionNum;

    NSMutableArray *recommendStoreArray;
    NSMutableArray *myStoreArray;

}
@property (weak, nonatomic) IBOutlet UITableView *storeTable;
@property (weak, nonatomic) IBOutlet UILabel *addStoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *addStoreIcon;

@end
