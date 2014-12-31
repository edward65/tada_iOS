//
//  Config.h
//  Oi
//
//  Created by Ed on 2014/9/2.
//  Copyright (c) 2014年 Hsiang-Lin Yeh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Config : NSObject

+ (Config *)sharedInstance;


// v1.0

//system
@property (nonatomic) NSString              *TADA_SERVER;


@property (nonatomic) float          viewAnimateTime;

@property (nonatomic) BOOL         isLogged;


@property (nonatomic)NSMutableArray    *districtArray;//服務區域

@property (nonatomic) NSDictionary              *orderDict;//order 內容


@property (nonatomic) NSString              *uniId;


@property (nonatomic) NSMutableArray              *countryCodeArray;
@property (nonatomic) NSMutableDictionary              *callingCodeDict;













/// ----old data





//user data
@property (nonatomic) NSString              *userApnToken;
@property (nonatomic) NSString              *userId;
@property (nonatomic) NSString              *userPhoneNum;
@property (nonatomic) NSString              *userFirstName;
@property (nonatomic) NSString              *userLastName;

@property (nonatomic) BOOL              isNeedToUpdateAPNs;
@property (nonatomic) BOOL              isNeedToUpdateUserId;

@property (nonatomic) BOOL              isAPNSPermissionGrated;

@property (nonatomic) BOOL              isShowInstruction;


@property (nonatomic) BOOL              isContactsLoaded;

@property (nonatomic) BOOL              isShowAPNSPermissionReminder;
@property (nonatomic) BOOL              isShowNotificationReminder;
@property (nonatomic) BOOL              isShowContactsReminder;




@property (nonatomic) BOOL         isGroupEditing;// group 編輯中



@property (nonatomic)NSMutableArray    *friendsGroupArray; //每組都有以下內容 friendsNum groupName


@property (nonatomic) int          friendsGroupIndex;//現在選擇的朋友群組 (預設為 0)
@property (nonatomic) int          closeFriendsNum;//現在群組的朋友數量
@property (nonatomic)NSMutableArray    *removeCloseFriendIndexArray;//@closeFriendsArray （包含所有的朋友群組）




@end
