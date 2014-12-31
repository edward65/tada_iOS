//
//  RequestViewController.h
//  Tada
//
//  Created by Ed on 2014/12/16.
//  Copyright (c) 2014年 cloudonline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderItemViewController.h"
#import "OrderItemView.h"





@interface OrderViewController : UIViewController<UITextViewDelegate>{
    
    
    Config *config;
    
    int orderItemsCount;
    
    int initY;
    
    
    UIBarButtonItem *rightButtonNoraml;
    UIBarButtonItem *leftButtonNoraml;
    
    UIBarButtonItem *rightButtonEditing;
    UIBarButtonItem *leftButtonEditing;
    
    BOOL isNeedReload;


}
@property (weak, nonatomic) IBOutlet UILabel *requestLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@end
