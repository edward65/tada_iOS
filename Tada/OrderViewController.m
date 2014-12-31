//
//  RequestViewController.m
//  Tada
//
//  Created by Ed on 2014/12/16.
//  Copyright (c) 2014年 cloudonline. All rights reserved.
//

#import "OrderViewController.h"

#define ORDER_ITEM_HEIGHT ((int) 60)

NSString *ORDER_RELOAD_NOTIFICATION = @"ORDER_RELOAD_NOTIFICATION";


@interface OrderViewController ()

@end

@implementation OrderViewController
@synthesize contentScrollView;
@synthesize requestLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    config = [Config sharedInstance];
    
    
    rightButtonNoraml = [[UIBarButtonItem alloc] initWithTitle:@"紀錄"
                                                                    style:UIBarButtonItemStyleDone target:self action:@selector(history)];
    self.navigationItem.rightBarButtonItem = rightButtonNoraml;
    
    
    leftButtonNoraml = [[UIBarButtonItem alloc] initWithTitle:@"設定"
                                                                    style:UIBarButtonItemStyleDone target:self action:@selector(setting)];
    self.navigationItem.leftBarButtonItem = leftButtonNoraml;
    
    
    
    rightButtonEditing = [[UIBarButtonItem alloc] initWithTitle:@"下一步"
                                                         style:UIBarButtonItemStyleDone target:self action:@selector(nextView)];
    
    leftButtonEditing = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                        style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh:) name:ORDER_RELOAD_NOTIFICATION object:nil];
    
    OrderItemViewController *firstOrderItem = [[OrderItemViewController alloc] init];
    
    firstOrderItem.view.frame = CGRectMake(10, 100, 300, ORDER_ITEM_HEIGHT);
    
    firstOrderItem.orderItemView.itemLabel.text  = @"例：咖啡豆1包";
    
    firstOrderItem.orderItemView.itemTextView.delegate = self;
    
    firstOrderItem.orderItemView.tag = 1;
    
    
    [contentScrollView addSubview:firstOrderItem.orderItemView];
    
    
    [contentScrollView setContentSize:CGSizeMake(320, 504)];
    
    
    orderItemsCount = 1;
    initY = 63;
    
    
    isNeedReload = false;
    
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (isNeedReload) {
        [self reloadItems];
    }
    
}



- (void)reloadItems
{
    
    //清除 orderItems
    OrderItemView *orderItem = (OrderItemView *)[contentScrollView viewWithTag:1];
    orderItem.itemTextView.text = @"";
    
    self.navigationItem.rightBarButtonItem = rightButtonNoraml;
    self.navigationItem.leftBarButtonItem = leftButtonNoraml;
    
    requestLabel.alpha = 1.0f;
    requestLabel.hidden = false;
    requestLabel.alpha = 1.0f;
    
    orderItem.itemLabel.text  = @"例：咖啡豆1包";
    orderItem.frame = CGRectMake(10, 100, 300, ORDER_ITEM_HEIGHT);
    orderItem.itemLabel.hidden  = false;
    
    [self.view endEditing:YES];
    
    for (int i = 2; i<= orderItemsCount; i++) {
        [self removeOrderItem:i];
    }
    
    isNeedReload= false;
    
    
}


- (void)refresh:(id)sender
{
    
    isNeedReload = true;
    
}

- (void)back{
    
    OrderItemView *orderItem = (OrderItemView *)[contentScrollView viewWithTag:1];
    
    self.navigationItem.rightBarButtonItem = rightButtonNoraml;
    self.navigationItem.leftBarButtonItem = leftButtonNoraml;
    
    requestLabel.alpha = 0.0f;
    requestLabel.hidden = false;
    

    [self.view endEditing:YES];

    [UIView animateWithDuration:config.viewAnimateTime animations:^{
        requestLabel.alpha = 1.0f;
        
    }];
    
    //if 第1項沒有輸入內容且只有一個 item，則設定成預設值
    if ([orderItem.itemTextView.text isEqualToString:@""] && orderItemsCount==1) {
        orderItem.itemLabel.text  = @"例：咖啡豆1包";
    }
    
    
    //向上移動所有的 orderItems
    for (int i = 1; i<= orderItemsCount; i++) {
        
        orderItem = (OrderItemView *)[contentScrollView viewWithTag:i];
        
        [UIView animateWithDuration:config.viewAnimateTime animations:^{
            orderItem.frame = CGRectOffset( orderItem.frame, 0, 36 );
            
        }];
        
        
    }
    
    
    
    
}


- (void)nextView{
    
    
    //get all times
    
    NSString * items = @"";
    
    for (int i = 1; i<= (orderItemsCount-1); i++) {
        
        OrderItemView *orderItem = (OrderItemView *)[contentScrollView viewWithTag:i];
        items = [items stringByAppendingString:orderItem.itemTextView.text];
        
        if (i < (orderItemsCount-1)) {
            
            items = [items stringByAppendingString:@","];

        }

    }
    
    
    //set to config
    NSMutableDictionary *orderdict = [[NSMutableDictionary  alloc] init];
    orderdict = [config.orderDict mutableCopy];
    [orderdict setObject:items forKey:@"items"];
    [config setOrderDict:orderdict];
    
    
    UIViewController *nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"orderfromVC"];
    
    [self.navigationController pushViewController:nextVC animated:YES];
    
}


- (void)setting{
    
    
    
    
}

- (void)history{
    
    UIViewController *nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"orderhistoryVC"];
    [self.navigationController pushViewController:nextVC animated:YES];

    
}


#pragma mark - UITextViewDelegate




- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    
    //如果 requestLabel沒有 hidden 表示從 noraml 狀態進入 editing 狀態
    if (!requestLabel.hidden) {
        
        OrderItemView *orderItem = (OrderItemView *)textView.superview;

        self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.leftBarButtonItem = leftButtonEditing;
        
        
        [UIView animateWithDuration:config.viewAnimateTime animations:^{
            requestLabel.alpha = 0.0f;

        }completion:^(BOOL finished) {
            requestLabel.hidden = true;
        }];
        
        
        
        for (int i = 1; i<= orderItemsCount; i++) {
            
            OrderItemView *orderItem = (OrderItemView *)[contentScrollView viewWithTag:i];
            
            [UIView animateWithDuration:config.viewAnimateTime animations:^{
                orderItem.frame = CGRectOffset( orderItem.frame, 0, -36 );
                
            }];
            
            
        }
        
        
        //如果是 first item  而且內容為空，則轉換  label
        if (orderItem.tag == 1 && [orderItem.itemTextView.text isEqualToString:@""]) {
            orderItem.itemLabel.text = @"第 1 項";

        }
        
        
        
        
    }
    
    return YES;

}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    OrderItemView *orderItem = (OrderItemView *)textView.superview;
    
    
    //輸入品項文字，增加下一個項目
    if ([textView.text length] == 0 && [text length] == 1  && ![text isEqualToString:@"\n"]) {

        orderItem.itemLabel.hidden = true;
        [self addOrderItem:((int)orderItem.tag+1)];
        if ((int)orderItem.tag == 1) {
            self.navigationItem.rightBarButtonItem = rightButtonEditing;
            
        }

        
        
    //清除品項文字，移除下一個項目
    }else if([textView.text length] == 1 && [text length] == 0){

        orderItem.itemLabel.hidden = false;
        
        //倒數第二個，移除最後一個，其餘不動
        if (orderItem.tag == orderItemsCount-1) {

            [self removeOrderItem:((int)orderItem.tag+1)];

        }
        
        if ((int)orderItem.tag == 1) {
            self.navigationItem.rightBarButtonItem = nil;
            
        }
        
    
    //品項無文字內容後再按 delete key, 回到上一個品項
    }else if([textView.text length] == 0 && [text length] == 0){
        
        if ((int)orderItem.tag != 1) {
            
            
            [orderItem.itemTextView resignFirstResponder];
            
            OrderItemView *lastOrderItem = (OrderItemView *)[contentScrollView viewWithTag:((int)orderItem.tag-1)];
            
            [lastOrderItem.itemTextView becomeFirstResponder];
            
            
            //如果不是最後一個 order item,則刪除此 order item 並重新整理 order items
            if (orderItem.tag != orderItemsCount) {
                
                
                [self reOrderItems:(int)orderItem.tag];

            }
            

            return NO;
            
            
        }else if(orderItemsCount == 2){//刪除 item2
            

        
            
            OrderItemView *orderItem = (OrderItemView *)[contentScrollView viewWithTag:2];
            
            [UIView animateWithDuration:config.viewAnimateTime animations:^{
                orderItem.alpha = 0.0f;
            }completion:^(BOOL finished) {
                
                [orderItem removeFromSuperview];
                orderItemsCount--;
                
            }];
        
        }
        
    }
    
    
    //按下換行 key
    if([text isEqualToString:@"\n"] ) {
        

        if ([textView.text length] != 0) {
            
            [orderItem.itemTextView resignFirstResponder];
            
            OrderItemView *nextOrderItem = (OrderItemView *)[contentScrollView viewWithTag:((int)orderItem.tag+1)];
            
            [nextOrderItem.itemTextView becomeFirstResponder];
        }

        return NO;

    }
    
    return YES;
    
    
}



- (void)addOrderItem:(int)order{
    
    
    OrderItemViewController *orderItem = [[OrderItemViewController alloc] init];
    
    int y= initY +(ORDER_ITEM_HEIGHT* (order -1));
    
    NSString *itemLabelText = [NSString stringWithFormat:@"第 %d 項",order];
    
    orderItem.view.frame = CGRectMake(10, y, 300, ORDER_ITEM_HEIGHT);
    
    orderItem.orderItemView.itemLabel.text  = itemLabelText;
    
    orderItem.orderItemView.itemTextView.delegate = self;
    
    orderItem.orderItemView.tag = order;
    
    orderItem.orderItemView.alpha = 0.0f;
    
    
    [contentScrollView addSubview:orderItem.orderItemView];
    
    orderItemsCount++;
    
    
    [UIView animateWithDuration:config.viewAnimateTime animations:^{
        orderItem.orderItemView.alpha = 1.0f;
    }];
    
}

- (void)removeOrderItem:(int)order{
    
    OrderItemView *orderItem = (OrderItemView *)[contentScrollView viewWithTag:order];
    
    [self removeItem:orderItem];
    
    
    
}


-(void)removeItem:(UIView*)view{
    
    [UIView animateWithDuration:config.viewAnimateTime animations:^{
        view.alpha = 0.0f;
    }completion:^(BOOL finished) {
        orderItemsCount--;
        [view removeFromSuperview];
    }];


}




- (void)reOrderItems:(int)order{
    
    OrderItemView *orderItem = (OrderItemView *)[contentScrollView viewWithTag:order];

    
    [UIView animateWithDuration:config.viewAnimateTime animations:^{
        orderItem.alpha = 0.0f;
    }completion:^(BOOL finished) {
        
        

        [orderItem removeFromSuperview];
        
        for (int i = order+1; i<= orderItemsCount; i++) {
            
            OrderItemView *nextOrderItem = (OrderItemView *)[contentScrollView viewWithTag:i];
            
            nextOrderItem.tag = i-1;
            
            NSString *itemLabelText = [NSString stringWithFormat:@"第 %d 項",i-1];
            
            nextOrderItem.itemLabel.text = itemLabelText;

            
            [UIView animateWithDuration:config.viewAnimateTime animations:^{
                
                int y = nextOrderItem.frame.origin.y - ORDER_ITEM_HEIGHT;
                nextOrderItem.frame = CGRectMake(10, y, 300, ORDER_ITEM_HEIGHT);


            }];

            
        }
        
        
        
        orderItemsCount--;
        
        
        
    }];
    
    
}



#pragma mark - Orientations


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ORDER_RELOAD_NOTIFICATION object:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
