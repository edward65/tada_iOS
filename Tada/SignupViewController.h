//
//  SignupViewController.h
//  Tada
//
//  Created by Ed on 2014/12/15.
//  Copyright (c) 2014年 cloudonline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SendEmailViewController.h"
#import "TadaServer.h"


@interface SignupViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate,UITextFieldDelegate,UIScrollViewDelegate,LoginDelegate>{

    NSMutableArray *_pickerData;
    Config *config;
    UIActivityIndicatorView *indicator;

}
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *districtTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *inviteTextField;

@property (weak, nonatomic) IBOutlet UIButton *termsBtn;
- (IBAction)termsAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
- (IBAction)phoneNumTouch:(id)sender;
- (IBAction)inviteTouch:(id)sender;
- (IBAction)sendAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
