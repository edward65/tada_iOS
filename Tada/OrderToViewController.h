//
//  OrderToViewController.h
//  Tada
//
//  Created by Ed on 2014/12/16.
//  Copyright (c) 2014年 cloudonline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataBaseManager.h"


@interface OrderToViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    
    Config *config;
    DataBaseManager *dataBaseManager;

    NSMutableArray    *myPlaceArray;

}


@property (weak, nonatomic) IBOutlet UITableView *placeTable;
@property (weak, nonatomic) IBOutlet UILabel *addPlaceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *addPlaceIcon;
@property (weak, nonatomic) IBOutlet UITextField *addPlaceTextField;

@end
