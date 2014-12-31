//
//  AddPlaceViewController.h
//  Tada
//
//  Created by Ed on 2014/12/26.
//  Copyright (c) 2014年 cloudonline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataBaseManager.h"


@interface AddPlaceViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate,UITextFieldDelegate>{
    
    NSArray *_pickerData;
    
    Config *config;
    DataBaseManager *dataBaseManager;
    
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *placeNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *placeNameTextField;


@property (weak, nonatomic) IBOutlet UILabel *placeDistLabel;
@property (weak, nonatomic) IBOutlet UITextField *placeDistTextField;

@property (weak, nonatomic) IBOutlet UILabel *placeAddressLabel;
@property (weak, nonatomic) IBOutlet UITextField *placeAddressTextField;

@property (weak, nonatomic) IBOutlet UITextField *placePhoneTextField;

@property (weak, nonatomic) IBOutlet UILabel *placeNoteLabel;
@property (weak, nonatomic) IBOutlet UITextField *placeNoteTextField;

@property (weak, nonatomic) IBOutlet UIPickerView *picker;
- (IBAction)addAction:(id)sender;

@end
