//
//  OrderFromViewController.m
//  Tada
//
//  Created by Ed on 2014/12/16.
//  Copyright (c) 2014年 cloudonline. All rights reserved.
//

#import "OrderFromViewController.h"

@interface OrderFromViewController ()

@end

@implementation OrderFromViewController
@synthesize addStoreLabel;
@synthesize addStoreIcon;
@synthesize storeTable;

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
    
    NSMutableArray *storeArray = [dataBaseManager storeArray];
    recommendStoreArray = storeArray[0];
    myStoreArray = storeArray[1];
    [storeTable reloadData];
    
    
    
}



- (void)addMyStore:(NSString *)storeName{
    
    [dataBaseManager addStore:storeName isRecommend:NO];
    
    NSMutableArray *storeArray = [dataBaseManager storeArray];
    recommendStoreArray = storeArray[0];
    myStoreArray = storeArray[1];
    
    
}

#pragma mark -- UITableView Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    return 62;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    int section = (int)indexPath.section;
    int row = (int)indexPath.row;
    
    NSString * storeName = @"7-11";
    
    if (sectionNum == 2) {
        
        if (section == 0) {
            storeName =  [recommendStoreArray[row] objectForKey:@"store_name"];
        }else{
            storeName =  [myStoreArray[row] objectForKey:@"store_name"];
        }
        
        
    }else if(sectionNum == 1){
        
        //判斷哪一種有資料
        if ([recommendStoreArray count] == 0) {
            storeName =  [myStoreArray[row] objectForKey:@"store_name"];
            
            
        }else{
            storeName =  [recommendStoreArray[row] objectForKey:@"store_name"];
        }
        
        
    }
    
    
    NSMutableDictionary *orderdict = [[NSMutableDictionary  alloc] init];
    orderdict = [config.orderDict mutableCopy];
    [orderdict setObject:storeName forKey:@"from_placeName"];
    [config setOrderDict:orderdict];
    
    
    UIViewController *nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ordertoVC"];
    
    [self.navigationController pushViewController:nextVC animated:YES];
    
}

#pragma mark -- UITableView DataSource


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    sectionNum = 0;
    
    if ([recommendStoreArray count] != 0) {
        sectionNum++;
    }
    
    if ([myStoreArray count] != 0) {
        sectionNum++;
    }
    

    return sectionNum;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    if (sectionNum == 2) {
        
        if (section == 0) {
            return [recommendStoreArray count];
        }else{
            return [myStoreArray count];
        }
        
        
    }else if(sectionNum == 1){
        
        //判斷哪一種有資料
        if ([recommendStoreArray count] == 0) {
            return [myStoreArray count];
        }else{
            return [recommendStoreArray count];
        }

    
    }
    
    // sectionNum = 0
    return 0;
    

    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    int section = (int)indexPath.section;
    int row = (int)indexPath.row;
    
    NSString * cellName = @"7-11";
    
    if (sectionNum == 2) {
        
        if (section == 0) {
            cellName =  [recommendStoreArray[row] objectForKey:@"store_name"];
        }else{
            cellName =  [myStoreArray[row] objectForKey:@"store_name"];
        }
        
        
    }else if(sectionNum == 1){
        
        //判斷哪一種有資料
        if ([recommendStoreArray count] == 0) {
            cellName =  [myStoreArray[row] objectForKey:@"store_name"];
            
            
        }else{
            cellName =  [recommendStoreArray[row] objectForKey:@"store_name"];
        }
        
        
    }
    
    
    
    
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

    return cell;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,22)];
    headerView.alpha = 0.7;
    
    UIView *bgView = [[UIView alloc] initWithFrame:headerView.frame];
    UIColor * bgColor = [UIColor clearColor];
    bgView.backgroundColor = bgColor;
    bgView.alpha = 0.3;
    [headerView addSubview:bgView];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(16,0,tableView.frame.size.width-16,22)];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    
    
    
    if (sectionNum == 2) {
        
        if (section == 0) {
            headerLabel.text = @"推薦店家";
        }else{
            headerLabel.text = @"喜愛店家";
        }
        
        
    }else if(sectionNum == 1){
        
        //判斷哪一種有資料
        if ([recommendStoreArray count] == 0) {
            headerLabel.text = @"喜愛店家";
        }else{
            headerLabel.text = @"推薦店家";
        }
        
        
    }
    
    
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textColor = [TadaColor lightbrownColor];
    headerLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    
    
    [headerView addSubview:headerLabel];
    return headerView;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return  30.0;
}


#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{

    addStoreLabel.hidden = true;
    addStoreIcon.hidden = true;


}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    //清除內容
    if ((range.location == 0) && (string.length == 0))
    {
        textField.text = @"";
        [textField resignFirstResponder];
        addStoreLabel.hidden = false;
        addStoreIcon.hidden = false;
        
    }


    return YES;


}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    if (![textField.text isEqualToString:@""]) {
        [self addMyStore:textField.text];
    }
    
    textField.text = @"";
    addStoreLabel.hidden = false;
    addStoreIcon.hidden = false;
    
    [storeTable reloadData];
    
    return YES;
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
