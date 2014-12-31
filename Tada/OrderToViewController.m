//
//  OrderToViewController.m
//  Tada
//
//  Created by Ed on 2014/12/16.
//  Copyright (c) 2014年 cloudonline. All rights reserved.
//

#import "OrderToViewController.h"

@interface OrderToViewController ()

@end

@implementation OrderToViewController
@synthesize placeTable;
@synthesize addPlaceLabel;
@synthesize addPlaceIcon;
@synthesize addPlaceTextField;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    config = [Config sharedInstance];
    dataBaseManager = [DataBaseManager sharedDBManager];

    
    
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc]
                                initWithTitle:@"返回"
                                style:UIBarButtonItemStyleDone
                                target:self
                                action:nil];
    self.navigationController.navigationBar.topItem.backBarButtonItem=btnBack;
    
    

}




- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    myPlaceArray = [dataBaseManager placeArray];
    
    [addPlaceTextField setUserInteractionEnabled:true];
    
    [placeTable reloadData];
    
    
}



#pragma mark -- UITableView Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    return 62;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSMutableDictionary *orderdict = [[NSMutableDictionary  alloc] init];
    orderdict = [config.orderDict mutableCopy];
    
    int row = (int)indexPath.row;
    
    // place_table data base : place_name, place_district, place_address, place_phone, place_note, isshow, build_time
    NSString * place_name =  [myPlaceArray[row] objectForKey:@"place_name"];
    NSString * place_district =  [myPlaceArray[row] objectForKey:@"place_district"];
    NSString * place_address =  [myPlaceArray[row] objectForKey:@"place_address"];
    NSString * place_phone =  [myPlaceArray[row] objectForKey:@"place_phone"];
    NSString * place_note =  [myPlaceArray[row] objectForKey:@"place_note"];
    

    
    // place_table config : items, from_placeName,to_placeName, to_placeDict, to_placeAddress, to_placePhone, to_placeNote
    [orderdict setObject:place_name forKey:@"to_placeName"];
    [orderdict setObject:place_district forKey:@"to_placeDict"];
    [orderdict setObject:place_address forKey:@"to_placeAddress"];
    [orderdict setObject:place_phone forKey:@"to_placePhone"];
    [orderdict setObject:place_note forKey:@"to_placeNote"];
    
    [config setOrderDict:orderdict];
    
    
    UIViewController *nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"orderreviewVC"];
    
    [self.navigationController pushViewController:nextVC animated:YES];

    
    
}

#pragma mark -- UITableView DataSource


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [myPlaceArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    int row = (int)indexPath.row;
    NSString * cellName =  [myPlaceArray[row] objectForKey:@"place_name"];
    
    static NSString * cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = cellName;
    cell.textLabel.textColor = [TadaColor yellowColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:33];
    cell.tag = row;
    
    return cell;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return nil;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return  0.0;
}


#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
    [textField setUserInteractionEnabled:false];
        
    UIViewController *nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"addplaceVC"];
    
    [self.navigationController pushViewController:nextVC animated:YES];
    
    
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

@end
