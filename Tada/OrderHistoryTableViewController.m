//
//  OrderHistoryTableViewController.m
//  Tada
//
//  Created by Ed on 2014/12/31.
//  Copyright (c) 2014年 cloudonline. All rights reserved.
//

#import "OrderHistoryTableViewController.h"

@interface OrderHistoryTableViewController ()

@end

@implementation OrderHistoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
    config = [Config sharedInstance];
    dataBaseManager = [DataBaseManager sharedDBManager];
    
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc]
                                initWithTitle:@"訂購"
                                style:UIBarButtonItemStyleDone
                                target:self
                                action:nil];
    self.navigationController.navigationBar.topItem.backBarButtonItem=btnBack;
}




- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    orderArray = [dataBaseManager orderArray];
    
    
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [orderArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"itemCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [TadaColor yellowColor];
    [cell setSelectedBackgroundView:bgColorView];
        
    // Display recipe in the table cell
    UILabel *timeLabel = (UILabel *)[cell viewWithTag:100];
    
    UILabel *itemsLabel = (UILabel *)[cell viewWithTag:101];
    itemsLabel.text = [orderArray[indexPath.row] objectForKey:@"items"];
    
    UILabel *statusLabel = (UILabel *)[cell viewWithTag:102];
    
    
    NSString *orderStatus = [orderArray[indexPath.row] objectForKey:@"order_status"];
    
    
    
    //order_status:產生(start)，失敗(failure)，接受處理中(accept)，不接受(unaccept)，完成(finished)
    if ([orderStatus isEqualToString:@"start"]) { //處理中
        timeLabel.text = [orderArray[indexPath.row] objectForKey:@"build_time"];
        statusLabel.text = @"處理中";

    }else if ([orderStatus isEqualToString:@"failure"]){//接受，遞送中
        
        timeLabel.text = [orderArray[indexPath.row] objectForKey:@"build_time"];
        statusLabel.text = @"訂購失敗";
        
        
    }else if ([orderStatus isEqualToString:@"accept"]){//接受，遞送中
    
        timeLabel.text = [orderArray[indexPath.row] objectForKey:@"build_time"];
        statusLabel.text = @"遞送中";

    
    }else if ([orderStatus isEqualToString:@"unaccept"]){//不接受
        
        timeLabel.text = [orderArray[indexPath.row] objectForKey:@"build_time"];
        statusLabel.text = @"訂單無效";

        
    }else if ([orderStatus isEqualToString:@"finished"]){//完成
        
        timeLabel.text = [orderArray[indexPath.row] objectForKey:@"finish_time"];
        statusLabel.text = @"遞送完成";

        
    }
    
    
    
    
    
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    OrderProcessViewController *orderVC = [self.storyboard instantiateViewControllerWithIdentifier:@"orderprocessVC"];
    orderVC.orderIndex = (int)indexPath.row;
    
    [self.navigationController pushViewController:orderVC animated:YES];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
