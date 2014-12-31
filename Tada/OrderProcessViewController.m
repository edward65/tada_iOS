//
//  OrderProcessViewController.m
//  Tada
//
//  Created by Ed on 2014/12/16.
//  Copyright (c) 2014年 cloudonline. All rights reserved.
//

#import "OrderProcessViewController.h"

@interface OrderProcessViewController ()

@end

@implementation OrderProcessViewController
@synthesize orderItemsLabel;
@synthesize statusLabel;
@synthesize substatusLabel;
@synthesize statusImage;
@synthesize statusNoteLabel;
@synthesize orderBtn;
@synthesize shareBtn;
@synthesize orderIndex;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    config = [Config sharedInstance];
    dataBaseManager = [DataBaseManager sharedDBManager];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"OK"
                                                         style:UIBarButtonItemStyleDone target:self action:@selector(finished)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    [self.navigationItem setHidesBackButton:YES];
    


    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    orderArray = [dataBaseManager orderArray];
    
    
    //判斷 order 狀態：order_status:產生(start)，失敗(failure)，接受處理中(accept)，不接受(unaccept)，完成(finished)
    
    NSString * orderStatusString = [orderArray[orderIndex] objectForKey:@"order_status"];
    
    if ([orderStatusString isEqualToString:@"start"]) {
        
        orderStatus = Start;
        [self setStartUI];
        
    }else if ([orderStatusString isEqualToString:@"failure"]){
        
        orderStatus = Failure;
        [self setFailureUI];
        
    }else if ([orderStatusString isEqualToString:@"accept"]){
        
        orderStatus = Accept;
        [self setAcceptUI];
        
    }else if ([orderStatusString isEqualToString:@"unaccept"]){
        
        orderStatus = UnAccept;
        [self setUnacceptUI];
        
    }else if ([orderStatusString isEqualToString:@"finished"]){
        
        orderStatus = Finished;
        [self setFinishedUI];
        
    }
    
    
    orderItemsLabel.text = [orderArray[orderIndex] objectForKey:@"items"];
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    //animation for test
    if (orderStatus == Start) {
        // Delay execution of my block for 10 seconds.
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self setAcceptAnimation];
        });
        
    }else if(orderStatus == Accept){
    
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self setFinishedAnimation];
        });
    
    }
    

    
}



- (void)finished {
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ORDER_RELOAD_NOTIFICATION" object:nil];

    
    UIViewController *rootViewController = self.navigationController.viewControllers[0];
    UIViewController *nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"orderhistoryVC"];
    [self.navigationController popToRootViewControllerAnimated:NO];
    [rootViewController.navigationController pushViewController:nextVC animated:YES];
    

    
}



//五種 order 狀態 UI 設定

- (void)setStartUI{
    
    statusLabel.text = @"處理中";
    substatusLabel.text = [orderArray[orderIndex] objectForKey:@"build_time"];
    [statusImage setImage:[UIImage imageNamed:@"delivering.png"]];
    statusNoteLabel.hidden = false;
    orderBtn.hidden = true;
    shareBtn.hidden = true;
    
    
}

- (void)setFailureUI{
    
    statusLabel.text = @"訂購失敗";
    substatusLabel.text = [orderArray[orderIndex] objectForKey:@"build_time"];
    [statusImage setImage:[UIImage imageNamed:@"failure.png"]];
    statusNoteLabel.hidden = false;
    orderBtn.hidden = true;
    shareBtn.hidden = true;
}

- (void)setUnacceptUI{
    
    statusLabel.text = @"不接受訂購";
    substatusLabel.text = [orderArray[orderIndex] objectForKey:@"build_time"];
    [statusImage setImage:[UIImage imageNamed:@"unaccept.png"]];
    statusNoteLabel.hidden = false;
    orderBtn.hidden = true;
    shareBtn.hidden = true;
    
}


- (void)setAcceptUI{
    
    
    statusLabel.text = @"遞送中";
    substatusLabel.text = @"請稍等";
    [statusImage setImage:[UIImage imageNamed:@"delivering.png"]];
    statusNoteLabel.hidden = false;
    orderBtn.hidden = true;
    shareBtn.hidden = true;
    
}


- (void)setFinishedUI{
    
    statusLabel.text = @"遞送完成!";
    substatusLabel.text = [orderArray[orderIndex] objectForKey:@"finish_time"];
    [statusImage setImage:[UIImage imageNamed:@"delivery_done.png"]];
    statusNoteLabel.hidden = true;
    orderBtn.hidden = false;
    shareBtn.hidden = false;

    
}

- (void)setAcceptAnimation{
    

    [UIView animateWithDuration:0.3 animations:^() {
        
        statusImage.alpha = 0.0;
        statusLabel.alpha = 0.0;
        substatusLabel.alpha = 0.0;
                         
       
    }completion:^(BOOL finished) {
        
        [statusImage setImage:[UIImage imageNamed:@"delivering.png"]];
        statusLabel.text = @"遞送中";
        substatusLabel.text = @"請稍等";

        
        [UIView animateWithDuration:0.3 animations:^() {
            
            
            statusImage.alpha = 1.0;
            statusLabel.alpha = 1.0;
            substatusLabel.alpha = 1.0;
            
        }completion:^(BOOL finished) {
            
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [self setFinishedAnimation];
            });
            
            
        }];

                     
    }];
    
}

- (void)setFinishedAnimation{
    
    
    [UIView animateWithDuration:0.3 animations:^() {
    
        statusImage.alpha = 0.0;
        statusNoteLabel.alpha = 0.0;
        statusLabel.alpha = 0.0;
        substatusLabel.alpha = 0.0;
    
    
    }completion:^(BOOL finished) {
    
        [statusImage setImage:[UIImage imageNamed:@"delivery_done.png"]];
        statusNoteLabel.hidden = true;
        orderBtn.alpha = 0.0;
        orderBtn.alpha = 0.0;
        statusLabel.text = @"遞送完成!";
        substatusLabel.text = [orderArray[0] objectForKey:@"build_time"];
        orderBtn.hidden = false;
        shareBtn.hidden = false;
    
    
        [UIView animateWithDuration:0.3 animations:^() {
        
            statusImage.alpha = 1.0;
            orderBtn.alpha = 1.0;
            orderBtn.alpha = 1.0;
            statusLabel.alpha = 1.0;
            substatusLabel.alpha = 1.0;
        
        }];

                         
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)orderAction:(id)sender {
}

- (IBAction)shareAction:(id)sender {
}
@end
