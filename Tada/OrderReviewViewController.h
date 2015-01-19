//
//  OrderReviewViewController.h
//  Tada
//
//  Created by Ed on 2014/12/16.
//  Copyright (c) 2014年 cloudonline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataBaseManager.h"
#import "OrderProcessViewController.h"
#import "TadaServer.h"


@interface OrderReviewViewController : UIViewController{


    Config *config;
    DataBaseManager *dataBaseManager;
    NSMutableDictionary *orderdict;

}
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *orderItems;
@property (weak, nonatomic) IBOutlet UILabel *placeName;
- (IBAction)sendAction:(id)sender;

@end
