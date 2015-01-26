//
//  SignupViewController.m
//  Tada
//
//  Created by Ed on 2014/12/15.
//  Copyright (c) 2014年 cloudonline. All rights reserved.
//

#import "SignupViewController.h"

@interface SignupViewController ()

@end

@implementation SignupViewController

@synthesize userNameTextField;
@synthesize districtTextField;
@synthesize phoneTextField;
@synthesize inviteTextField;
@synthesize picker;
@synthesize scrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   // [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:(float)(254.0/255.0) green:(float)(215.0/255.0) blue:(float)(63.0/255.0) alpha:(1.0)]];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    
    config =[Config sharedInstance];
    
    
    // Initialize Data
    _pickerData =  [config.service_area mutableCopy];
    
    scrollView.contentSize=CGSizeMake(320,506);
    
    
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc]
                                initWithTitle:@""
                                style:UIBarButtonItemStyleDone
                                target:self
                                action:nil];
    self.navigationController.navigationBar.topItem.backBarButtonItem=btnBack;
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"送出"
                                                                    style:UIBarButtonItemStyleDone target:self action:@selector(nextView:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    
    
    //設定 inviteTextField
    
    if (!config.inviteEnable) {
        
        phoneTextField.returnKeyType = UIReturnKeyDone;
        
        inviteTextField.hidden = YES;//隱藏邀請碼輸入區
    
    }
    



}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];

    
}


- (IBAction)termsAction:(id)sender{


}




#pragma mark - UITextFieldDelegate



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    if([textField isEqual:userNameTextField]){
        
        [phoneTextField becomeFirstResponder];
        
        [scrollView setContentOffset:CGPointMake(0, 85) animated:YES];
        
    }else if ([textField isEqual:phoneTextField]){
    
        if (config.inviteEnable) {
            
            [inviteTextField becomeFirstResponder];
            
            [scrollView setContentOffset:CGPointMake(0, 170) animated:YES];
            
        }else{
        
            [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        
        }
    
    }else if ([textField isEqual:inviteTextField]){
        
        [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        
    }
    
    return NO;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    
    [self dismissPickerView];
    
    if ([textField isEqual:phoneTextField]) {
        
        [scrollView setContentOffset:CGPointMake(0, 85) animated:YES];
        
    }else if([textField isEqual:inviteTextField]){
        
        [scrollView setContentOffset:CGPointMake(0, 170) animated:YES];

    }

    
    if ([textField isEqual:districtTextField]) {
        
        [self.view endEditing:YES];

        [self showPickerView];
        
        return NO;

    }
    
    return YES;
}




#pragma mark - UIPickerViewDelegate

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickerData.count;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    districtTextField.text = _pickerData[row];

}




// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _pickerData[row];
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



- (IBAction)phoneNumTouch:(id)sender {
    [self dismissPickerView];

}

- (IBAction)inviteTouch:(id)sender {
    [self dismissPickerView];

}

- (IBAction)nextView:(id)sender {
    
    
    NSString *vcIdentifier = @"verifycodeVC";
    
    if ([districtTextField.text isEqualToString:@"其他地區"]) {
        vcIdentifier = @"sendemailVC";
    }
    
    
    
    UIViewController *nextVC = [self.storyboard instantiateViewControllerWithIdentifier:vcIdentifier];
    
    [self.navigationController pushViewController:nextVC animated:YES];
}



- (void)showPickerView
{
    

    if (picker.frame.origin.y >= 568) {
        
        
        // To show the picker, we animate the frame and alpha values for the pickerview and the picker dismiss view.

        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.5 animations:^() {
                
                picker.frame = CGRectMake( 0, 264, picker.frame.size.width, picker.frame.size.height );
                
            }];
        });
    }
    

}

- (void)dismissPickerView
{
    
    if (picker.frame.origin.y < 568) {

        
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.5 animations:^() {
                
                picker.frame = CGRectMake( 0, 568, picker.frame.size.width, picker.frame.size.height );
                
            }];
        });
    }
}


@end
