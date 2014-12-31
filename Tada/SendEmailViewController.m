//
//  SendEmailViewController.m
//  Tada
//
//  Created by Ed on 2014/12/16.
//  Copyright (c) 2014年 cloudonline. All rights reserved.
//

#import "SendEmailViewController.h"

@interface SendEmailViewController ()

@end

@implementation SendEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"送出"
                                                                    style:UIBarButtonItemStyleDone target:self action:@selector(finished)];
    self.navigationItem.rightBarButtonItem = rightButton;
}


- (void)finished{
    
    
    //NSString *vcIdentifier = @"sendemailVC";
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
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
