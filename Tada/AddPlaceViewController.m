//
//  AddPlaceViewController.m
//  Tada
//
//  Created by Ed on 2014/12/26.
//  Copyright (c) 2014年 cloudonline. All rights reserved.
//

#import "AddPlaceViewController.h"

#define SCROLLVIEW_HEIGHT 524.0


@interface AddPlaceViewController ()

@end

@implementation AddPlaceViewController
@synthesize placeNameLabel;
@synthesize placeNameTextField;
@synthesize placeDistLabel;
@synthesize placeDistTextField;
@synthesize placeAddressLabel;
@synthesize placeAddressTextField;
@synthesize placePhoneTextField;
@synthesize placeNoteLabel;
@synthesize placeNoteTextField;
@synthesize picker;
@synthesize scrollView;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Initialize Data
    // Initialize Data
    _pickerData =  [[Config sharedInstance].service_area mutableCopy];
    
    
    config = [Config sharedInstance];
    dataBaseManager = [DataBaseManager sharedDBManager];
    
    
    
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc]
                                initWithTitle:@"返回"
                                style:UIBarButtonItemStyleDone
                                target:self
                                action:nil];
    self.navigationController.navigationBar.topItem.backBarButtonItem=btnBack;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // register for keyboard notifications
    
    [scrollView setContentSize:CGSizeMake(320, SCROLLVIEW_HEIGHT)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];

}

-(void)keyboardWillShow:(NSNotification*)aNotification {
    // Animate the current view out of the way

    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    int scrollView_height = 568 - kbSize.height;
    [scrollView setFrame:CGRectMake(0, 0, 320, scrollView_height)];
    
    
}



- (void)showPickerView
{
    
    
    if (picker.frame.origin.y >= 568) {
        
        
        // To show the picker, we animate the frame and alpha values for the pickerview and the picker dismiss view.
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.5 animations:^() {
                
                [scrollView setFrame:CGRectMake(0, 0, 320, 324)];
                picker.frame = CGRectMake( 0, 308, picker.frame.size.width, picker.frame.size.height );
                
            } completion:^(BOOL finished) {
                
                placeDistLabel.hidden = true;
                placeDistTextField.text = _pickerData[0];
                
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



#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    
    if ([textField isEqual:placeDistTextField]) {
        
        [placeNameTextField resignFirstResponder];
        [placePhoneTextField resignFirstResponder];
        [placeNoteTextField resignFirstResponder];
        [placeAddressTextField resignFirstResponder];
        
        [self showPickerView];
        
        return NO;
        
    }else if (textField == placeNoteTextField){
    
        textField.returnKeyType = UIReturnKeyGo;

    }else{
    
        textField.returnKeyType = UIReturnKeyDefault;
    
    }
    
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == placeNameTextField) {
        
        [placeNameTextField resignFirstResponder];
        [placeAddressTextField becomeFirstResponder];

        
    }else if (textField == placeAddressTextField){
        
        [placeAddressTextField resignFirstResponder];
        [placePhoneTextField becomeFirstResponder];

    
    }else if (textField == placePhoneTextField){
        
        
        [placePhoneTextField resignFirstResponder];
        [placeNoteTextField becomeFirstResponder];
        
        
    }else if (textField == placeNoteTextField){
        
        
        //go next page
        
        [self addAction:textField];
        
        
    }
    
    
    
    
    return NO;



}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    //輸入品項文字，隱藏對應 label
    if ([textField.text length] == 0 && [string length] == 1  && ![string isEqualToString:@"\n"]) {

        
        if (textField == placeNameTextField) {
            
            placeNameLabel.hidden = true;
            
        }else if (textField == placeAddressTextField){
            
            placeAddressLabel.hidden = true;
            
        }else if (textField == placeNoteTextField){
            
            placeNoteLabel.hidden = true;

        }

        
    //品項無文字內容後再按, show對應 label
    }else if([textField.text length] == 1 && [string length] == 0){
        
        if (textField == placeNameTextField) {
            
            placeNameLabel.hidden = false;
            
        }else if (textField == placeAddressTextField){
            
            placeAddressLabel.hidden = false;
            
        }else if (textField == placeNoteTextField){
            
            placeNoteLabel.hidden = false;
            
        }
        
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
    
    placeDistTextField.text = _pickerData[row];
    
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



- (IBAction)addAction:(id)sender {
    
    //check all field fill
    
    if ([self checkAllField]) {
        //add place to data base
        [dataBaseManager addPlace:placeNameTextField.text district:placeDistTextField.text address:placeAddressTextField.text phoneNum:placePhoneTextField.text note:placeNoteTextField.text];
        
        //Edward ToDo back to OrderToVC
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
    
}


- (BOOL)checkAllField
{
    return YES;
}




@end
