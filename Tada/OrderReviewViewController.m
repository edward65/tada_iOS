//
//  OrderReviewViewController.m
//  Tada
//
//  Created by Ed on 2014/12/16.
//  Copyright (c) 2014年 cloudonline. All rights reserved.
//

#import "OrderReviewViewController.h"

@interface OrderReviewViewController ()

@end

@implementation OrderReviewViewController
@synthesize storeName;
@synthesize orderItems;
@synthesize placeName;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    config = [Config sharedInstance];
    dataBaseManager = [DataBaseManager sharedDBManager];
    
    
    
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc]
                                initWithTitle:@""
                                style:UIBarButtonItemStyleDone
                                target:self
                                action:nil];
    self.navigationController.navigationBar.topItem.backBarButtonItem=btnBack;
    
    
    
    
    
    // place_table config : items, from_placeName,to_placeName, to_placeDict, to_placeAddress, to_placePhone, to_placeNote

    orderdict = [[NSMutableDictionary  alloc] init];
    orderdict = [config.orderDict mutableCopy];
    storeName.text = [orderdict objectForKey:@"from_placeName"];
    orderItems.text = [orderdict objectForKey:@"items"];
    placeName.text = [orderdict objectForKey:@"to_placeName"];

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

- (IBAction)sendAction:(id)sender {
    
    
    
    NSString *_storeName = [orderdict objectForKey:@"from_placeName"];
    NSString *_items = [orderdict objectForKey:@"items"];
    NSString *_placeName = [orderdict objectForKey:@"to_placeName"];
    NSString *_placeDistrict = [orderdict objectForKey:@"to_placeDict"];
    NSString *_placeAddress = [orderdict objectForKey:@"to_placeAddress"];
    NSString *_placePhone = [orderdict objectForKey:@"to_placePhone"];
    NSString *_placeNote = [orderdict objectForKey:@"to_placeNote"];

    
    //save order detail to data base
    [dataBaseManager addOrder:_items storeName:_storeName placeName:_placeName placeDistrict:_placeDistrict placeAddress:_placeAddress placePhone:_placePhone placeNote:_placeNote];
    
    
    
    NSString *receiveAddress = [NSString stringWithFormat:@"%@%@", _placeDistrict,_placeAddress];

    //sync to server
    [[TadaServer sharedServer] addOrder:_items
                              storeName:_storeName
                        receivePlace:_placeName
                         receiveAddress:receiveAddress
                           receivePhone:_placePhone
                            receiveNote:_placeNote];

    
    
    // go to orderprocessVC
    
    //orderIndex
    
    
    OrderProcessViewController *orderVC = [self.storyboard instantiateViewControllerWithIdentifier:@"orderprocessVC"];
    orderVC.orderIndex = 0;
    
    [self.navigationController pushViewController:orderVC animated:YES];
    
    
}
@end
