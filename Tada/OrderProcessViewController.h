//
//  OrderProcessViewController.h
//  Tada
//
//  Created by Ed on 2014/12/16.
//  Copyright (c) 2014年 cloudonline. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    Start=0,
    Failure,
    Accept,
    UnAccept,
    Finished,
    
} OrderStatus;

@interface OrderProcessViewController : UIViewController{

    Config *config;
    DataBaseManager *dataBaseManager;
    NSMutableArray *orderArray;
    
    OrderStatus orderStatus;

}

@property (nonatomic)  int orderIndex;


@property (weak, nonatomic) IBOutlet UILabel *orderItemsLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *substatusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *statusImage;
@property (weak, nonatomic) IBOutlet UILabel *statusNoteLabel;
@property (weak, nonatomic) IBOutlet UIButton *orderBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
- (IBAction)orderAction:(id)sender;
- (IBAction)shareAction:(id)sender;

@end
