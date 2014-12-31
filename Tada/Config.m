//
//  Config.m
//  Oi
//
//  Created by Ed on 2014/9/2.
//  Copyright (c) 2014年 Hsiang-Lin Yeh. All rights reserved.
//

#import "Config.h"

Config *_instance;

@implementation Config



+ (Config *)sharedInstance
{
    @synchronized(self) {
        if (!_instance) {
            _instance = [[self alloc] init];
        }
    }
    return _instance;
}




//system


- (NSString *)TADA_SERVER{
    
    //return @"http://oithem.com/Oi";

    return @"http://dev.worklohas.com:7009/Oi";
}


//---- (BOOL)isLogged

- (BOOL)isLogged
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![defaults objectForKey:@"isLogged"]) {
        
        // Default setting
        [defaults setBool:NO forKey:@"isLogged"];
        [defaults synchronize];
        
    }
    
    return [defaults boolForKey:@"isLogged"];
}


- (void)setIsLogged:(BOOL)isLogged
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setBool:isLogged forKey:@"isLogged"];
    
    [defaults synchronize];
}

//viewAnimateTime
- (float)viewAnimateTime
{
    
    return 0.35;
    
}



//districtArray ：服務地區必須和 server sync
- (NSMutableArray *)districtArray
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *mutableArray = [[NSMutableArray  alloc] init];
    
    
    if (![defaults objectForKey:@"districtArray"]) {
        
        mutableArray =  [NSMutableArray arrayWithObjects:@"台北市信義區",@"台北市大安區",nil];

        return mutableArray;
        
    }
    
    mutableArray = [[defaults objectForKey:@"districtArray"] mutableCopy];
    
    return mutableArray;
    
}


- (void)setDistrictArray:(NSMutableArray *)_array
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:_array forKey:@"districtArray"];
    
    [defaults synchronize];
    
    
    
}


- (NSMutableDictionary *)orderDict{
    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *orderdict = [[NSMutableDictionary  alloc] init];
    
    
    if (![defaults objectForKey:@"orderDict"]) {
        
        
        /*
        [orderdict setObject:[NSNull null] forKey:@"items"];
        [orderdict setObject:[NSNull null] forKey:@"from_placeName"];
        [orderdict setObject:[NSNull null] forKey:@"to_placeName"];
        [orderdict setObject:[NSNull null] forKey:@"to_placeDict"];
        [orderdict setObject:[NSNull null] forKey:@"to_placeAddress"];
        [orderdict setObject:[NSNull null] forKey:@"to_placePhone"];
        [orderdict setObject:[NSNull null] forKey:@"to_placeNote"];
         
         */
        
        return orderdict;
        
    }
    
    orderdict = [[defaults objectForKey:@"orderDict"] mutableCopy];
    
    
    
    return orderdict;

}


- (void)setOrderDict:(NSMutableDictionary *)_dict
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:_dict forKey:@"orderDict"];
    
    [defaults synchronize];
    
    
    
}


- (NSString *)uniId
{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    return (__bridge_transfer NSString *)uuidStringRef;
}




//countryCodeArray
- (NSMutableArray *)countryCodeArray
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *mutableArray = [[NSMutableArray  alloc] init];
    
    
    if (![defaults objectForKey:@"addCloseFriendIndexArray"]) {
        
        mutableArray =  [NSMutableArray arrayWithObjects:
                         @"US",@"TW",
                         @"AD",
                         @"AE",
                         @"AF",
                         @"AG",
                         @"AI",
                         @"AL",
                         @"AM",
                         @"AN",
                         @"AO",
                         @"AR",
                         @"AS",
                         @"AT",
                         @"AU",
                         @"AW",
                         @"AZ",
                         @"BA",
                         @"BB",
                         @"BD",
                         @"BE",
                         @"BF",
                         @"BG",
                         @"BH",
                         @"BI",
                         @"BJ",
                         @"BL",
                         @"BM",
                         @"BN",
                         @"BO",
                         @"BR",
                         @"BS",
                         @"BT",
                         @"BW",
                         @"BY",
                         @"BZ",
                         @"CA",
                         @"CC",
                         @"CD",
                         @"CF",
                         @"CG",
                         @"CH",
                         @"CI",
                         @"CK",
                         @"CL",
                         @"CM",
                         @"CN",
                         @"CO",
                         @"CR",
                         @"CU",
                         @"CV",
                         @"CX",
                         @"CY",
                         @"CZ",
                         @"DE",
                         @"DJ",
                         @"DK",
                         @"DM",
                         @"DO",
                         @"DZ",
                         @"EC",
                         @"EE",
                         @"EG",
                         @"ER",
                         @"ES",
                         @"ET",
                         @"FI",
                         @"FJ",
                         @"FK",
                         @"FM",
                         @"FO",
                         @"FR",
                         @"GA",
                         @"GB",
                         @"GD",
                         @"GE",
                         @"GF",
                         @"GG",
                         @"GH",
                         @"GI",
                         @"GL",
                         @"GM",
                         @"GN",
                         @"GP",
                         @"GQ",
                         @"GR",
                         @"GS",
                         @"GT",
                         @"GU",
                         @"GW",
                         @"GY",
                         @"HK",
                         @"HN",
                         @"HR",
                         @"HT",
                         @"HU",
                         @"ID",
                         @"IE",
                         @"IL",
                         @"IM",
                         @"IN",
                         @"IO",
                         @"IQ",
                         @"IR",
                         @"IS",
                         @"IT",
                         @"JE",
                         @"JM",
                         @"JO",
                         @"JP",
                         @"KE",
                         @"KG",
                         @"KH",
                         @"KI",
                         @"KM",
                         @"KN",
                         @"KP",
                         @"KR",
                         @"KW",
                         @"KY",
                         @"KZ",
                         @"LA",
                         @"LB",
                         @"LC",
                         @"LI",
                         @"LK",
                         @"LR",
                         @"LS",
                         @"LT",
                         @"LU",
                         @"LV",
                         @"LY",
                         @"MA",
                         @"MC",
                         @"MD",
                         @"ME",
                         @"MF",
                         @"MG",
                         @"MH",
                         @"MK",
                         @"ML",
                         @"MM",
                         @"MN",
                         @"MO",
                         @"MP",
                         @"MQ",
                         @"MR",
                         @"MS",
                         @"MT",
                         @"MU",
                         @"MV",
                         @"MW",
                         @"MX",
                         @"MY",
                         @"MZ",
                         @"NA",
                         @"NC",
                         @"NE",
                         @"NF",
                         @"NG",
                         @"NI",
                         @"NL",
                         @"NO",
                         @"NP",
                         @"NR",
                         @"NU",
                         @"NZ",
                         @"OM",
                         @"PA",
                         @"PE",
                         @"PF",
                         @"PG",
                         @"PH",
                         @"PK",
                         @"PL",
                         @"PM",
                         @"PN",
                         @"PR",
                         @"PS",
                         @"PT",
                         @"PW",
                         @"PY",
                         @"QA",
                         @"RE",
                         @"RO",
                         @"RS",
                         @"RU",
                         @"RW",
                         @"SA",
                         @"SB",
                         @"SC",
                         @"SD",
                         @"SE",
                         @"SG",
                         @"SH",
                         @"SI",
                         @"SJ",
                         @"SK",
                         @"SL",
                         @"SM",
                         @"SN",
                         @"SO",
                         @"SR",
                         @"ST",
                         @"SV",
                         @"SY",
                         @"SZ",
                         @"TC",
                         @"TD",
                         @"TG",
                         @"TH",
                         @"TJ",
                         @"TK",
                         @"TL",
                         @"TM",
                         @"TN",
                         @"TO",
                         @"TR",
                         @"TT",
                         @"TV",
                         @"TZ",
                         @"UA",
                         @"UG",
                         @"UY",
                         @"UZ",
                         @"VA",
                         @"VC",
                         @"VE",
                         @"VG",
                         @"VI",
                         @"VN",
                         @"VU",
                         @"WF",
                         @"WS",
                         @"YE",
                         @"YT",
                         @"ZA",
                         @"ZM",
                         @"ZW",nil];
        
        return mutableArray;
        
    }
    
    mutableArray = [[defaults objectForKey:@"addCloseFriendIndexArray"] mutableCopy];
    
    return mutableArray;
    
    
    
}


//callingCodeDict;
- (NSDictionary *)callingCodeDict
{
    
    NSDictionary *dictCodes = [NSDictionary dictionaryWithObjectsAndKeys:@"972", @"IL",
                               @"93", @"AF", @"355", @"AL", @"213", @"DZ", @"1", @"AS",
                               @"376", @"AD", @"244", @"AO", @"1", @"AI", @"1", @"AG",
                               @"54", @"AR", @"374", @"AM", @"297", @"AW", @"61", @"AU",
                               @"43", @"AT", @"994", @"AZ", @"1", @"BS", @"973", @"BH",
                               @"880", @"BD", @"1", @"BB", @"375", @"BY", @"32", @"BE",
                               @"501", @"BZ", @"229", @"BJ", @"1", @"BM", @"975", @"BT",
                               @"387", @"BA", @"267", @"BW", @"55", @"BR", @"246", @"IO",
                               @"359", @"BG", @"226", @"BF", @"257", @"BI", @"855", @"KH",
                               @"237", @"CM", @"1", @"CA", @"238", @"CV", @"345", @"KY",
                               @"236", @"CF", @"235", @"TD", @"56", @"CL", @"86", @"CN",
                               @"61", @"CX", @"57", @"CO", @"269", @"KM", @"242", @"CG",
                               @"682", @"CK", @"506", @"CR", @"385", @"HR", @"53", @"CU",
                               @"537", @"CY", @"420", @"CZ", @"45", @"DK", @"253", @"DJ",
                               @"1", @"DM", @"1", @"DO", @"593", @"EC", @"20", @"EG",
                               @"503", @"SV", @"240", @"GQ", @"291", @"ER", @"372", @"EE",
                               @"251", @"ET", @"298", @"FO", @"679", @"FJ", @"358", @"FI",
                               @"33", @"FR", @"594", @"GF", @"689", @"PF", @"241", @"GA",
                               @"220", @"GM", @"995", @"GE", @"49", @"DE", @"233", @"GH",
                               @"350", @"GI", @"30", @"GR", @"299", @"GL", @"1", @"GD",
                               @"590", @"GP", @"1", @"GU", @"502", @"GT", @"224", @"GN",
                               @"245", @"GW", @"595", @"GY", @"509", @"HT", @"504", @"HN",
                               @"36", @"HU", @"354", @"IS", @"91", @"IN", @"62", @"ID",
                               @"964", @"IQ", @"353", @"IE", @"972", @"IL", @"39", @"IT",
                               @"1", @"JM", @"81", @"JP", @"962", @"JO", @"77", @"KZ",
                               @"254", @"KE", @"686", @"KI", @"965", @"KW", @"996", @"KG",
                               @"371", @"LV", @"961", @"LB", @"266", @"LS", @"231", @"LR",
                               @"423", @"LI", @"370", @"LT", @"352", @"LU", @"261", @"MG",
                               @"265", @"MW", @"60", @"MY", @"960", @"MV", @"223", @"ML",
                               @"356", @"MT", @"692", @"MH", @"596", @"MQ", @"222", @"MR",
                               @"230", @"MU", @"262", @"YT", @"52", @"MX", @"377", @"MC",
                               @"976", @"MN", @"382", @"ME", @"1", @"MS", @"212", @"MA",
                               @"95", @"MM", @"264", @"NA", @"674", @"NR", @"977", @"NP",
                               @"31", @"NL", @"599", @"AN", @"687", @"NC", @"64", @"NZ",
                               @"505", @"NI", @"227", @"NE", @"234", @"NG", @"683", @"NU",
                               @"672", @"NF", @"1", @"MP", @"47", @"NO", @"968", @"OM",
                               @"92", @"PK", @"680", @"PW", @"507", @"PA", @"675", @"PG",
                               @"595", @"PY", @"51", @"PE", @"63", @"PH", @"48", @"PL",
                               @"351", @"PT", @"1", @"PR", @"974", @"QA", @"40", @"RO",
                               @"250", @"RW", @"685", @"WS", @"378", @"SM", @"966", @"SA",
                               @"221", @"SN", @"381", @"RS", @"248", @"SC", @"232", @"SL",
                               @"65", @"SG", @"421", @"SK", @"386", @"SI", @"677", @"SB",
                               @"27", @"ZA", @"500", @"GS", @"34", @"ES", @"94", @"LK",
                               @"249", @"SD", @"597", @"SR", @"268", @"SZ", @"46", @"SE",
                               @"41", @"CH", @"992", @"TJ", @"66", @"TH", @"228", @"TG",
                               @"690", @"TK", @"676", @"TO", @"1", @"TT", @"216", @"TN",
                               @"90", @"TR", @"993", @"TM", @"1", @"TC", @"688", @"TV",
                               @"256", @"UG", @"380", @"UA", @"971", @"AE", @"44", @"GB",
                               @"1", @"US", @"598", @"UY", @"998", @"UZ", @"678", @"VU",
                               @"681", @"WF", @"967", @"YE", @"260", @"ZM", @"263", @"ZW",
                               @"591", @"BO", @"673", @"BN", @"61", @"CC", @"243", @"CD",
                               @"225", @"CI", @"500", @"FK", @"44", @"GG", @"379", @"VA",
                               @"852", @"HK", @"98", @"IR", @"44", @"IM", @"44", @"JE",
                               @"850", @"KP", @"82", @"KR", @"856", @"LA", @"218", @"LY",
                               @"853", @"MO", @"389", @"MK", @"691", @"FM", @"373", @"MD",
                               @"258", @"MZ", @"970", @"PS", @"872", @"PN", @"262", @"RE",
                               @"7", @"RU", @"590", @"BL", @"290", @"SH", @"1", @"KN",
                               @"1", @"LC", @"590", @"MF", @"508", @"PM", @"1", @"VC",
                               @"239", @"ST", @"252", @"SO", @"47", @"SJ", @"963", @"SY",
                               @"886", @"TW", @"255", @"TZ", @"670", @"TL", @"58", @"VE",
                               @"84", @"VN", @"1", @"VG", @"1", @"VI", nil];
    
    
    return dictCodes;
    
    
}













/// ----old data



//userApnToken
- (NSString *)userApnToken
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![defaults objectForKey:@"userApnToken"]) {
        
        // Default setting
        [defaults setObject:nil forKey:@"userApnToken"];
        [defaults synchronize];
        
    }
    
    return [defaults objectForKey:@"userApnToken"];
    
}



- (void)setUserApnToken:(NSString *)userApnToken
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:userApnToken forKey:@"userApnToken"];
    [defaults synchronize];
    
}


//userId
- (NSString *)userId
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![defaults objectForKey:@"userId"]) {
        
        // Default setting
        [defaults setObject:nil forKey:@"userId"];
        [defaults synchronize];
        
    }
    
    return [defaults objectForKey:@"userId"];
    
}



- (void)setUserId:(NSString *)userId
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:userId forKey:@"userId"];
    [defaults synchronize];
    
}


//userPhoneNum
- (NSString *)userPhoneNum
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![defaults objectForKey:@"userPhoneNum"]) {
        
        // Default setting
        [defaults setObject:nil forKey:@"userPhoneNum"];
        [defaults synchronize];
        
    }
    
    return [defaults objectForKey:@"userPhoneNum"];
    
}



- (void)setUserPhoneNum:(NSString *)userPhoneNum
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:userPhoneNum forKey:@"userPhoneNum"];
    [defaults synchronize];
    
}



//userFirstName
- (NSString *)userFirstName
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![defaults objectForKey:@"userFirstName"]) {
        
        // Default setting
        [defaults setObject:nil forKey:@"userFirstName"];
        [defaults synchronize];
        
    }
    
    return [defaults objectForKey:@"userFirstName"];
    
}



- (void)setUserFirstName:(NSString *)userFirstName
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:userFirstName forKey:@"userFirstName"];
    [defaults synchronize];
    
}




//userLastName
- (NSString *)userLastName
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![defaults objectForKey:@"userLastName"]) {
        
        // Default setting
        [defaults setObject:nil forKey:@"userLastName"];
        [defaults synchronize];
        
    }
    
    return [defaults objectForKey:@"userLastName"];
    
}



- (void)setUserLastName:(NSString *)userLastName
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:userLastName forKey:@"userLastName"];
    [defaults synchronize];
    
}

//isNeedToUpdateAPNs
- (BOOL)isNeedToUpdateAPNs
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![defaults objectForKey:@"isNeedToUpdateAPNs"]) {
        
        // Default setting
        [defaults setBool:NO forKey:@"isNeedToUpdateAPNs"];
        [defaults synchronize];
        
    }
    
    return [defaults boolForKey:@"isNeedToUpdateAPNs"];
}


- (void)setIsNeedToUpdateAPNs:(BOOL)isNeed
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setBool:isNeed forKey:@"isNeedToUpdateAPNs"];
    
    [defaults synchronize];
}


//isNeedToUpdateUserId
- (BOOL)isNeedToUpdateUserId
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![defaults objectForKey:@"isNeedToUpdateUserId"]) {
        
        // Default setting
        [defaults setBool:NO forKey:@"isNeedToUpdateUserId"];
        [defaults synchronize];
        
    }
    
    return [defaults boolForKey:@"isNeedToUpdateUserId"];
}


- (void)setIsNeedToUpdateUserId:(BOOL)isNeed
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setBool:isNeed forKey:@"isNeedToUpdateUserId"];
    
    [defaults synchronize];
}


//isAPNSPermissionGrated
- (BOOL)isAPNSPermissionGrated
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![defaults objectForKey:@"isAPNSPermissionGrated"]) {
        
        // Default setting
        [defaults setBool:NO forKey:@"isAPNSPermissionGrated"];
        [defaults synchronize];
        
    }
    
    return [defaults boolForKey:@"isAPNSPermissionGrated"];
}


- (void)setIsAPNSPermissionGrated:(BOOL)isNeed
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setBool:isNeed forKey:@"isAPNSPermissionGrated"];
    
    [defaults synchronize];
}


//isShowInstruction
- (BOOL)isShowInstruction
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![defaults objectForKey:@"isShowInstruction"]) {
        
        // Default setting
        [defaults setBool:YES forKey:@"isShowInstruction"];
        [defaults synchronize];
        
    }
    
    return [defaults boolForKey:@"isShowInstruction"];
}


- (void)setIsShowInstruction:(BOOL)isNeed
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setBool:isNeed forKey:@"isShowInstruction"];
    
    [defaults synchronize];
}


//isShowAPNSPermissionReminder
- (BOOL)isShowAPNSPermissionReminder
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![defaults objectForKey:@"isShowAPNSPermissionReminder"]) {
        
        // Default setting
        [defaults setBool:YES forKey:@"isShowAPNSPermissionReminder"];
        [defaults synchronize];
        
    }
    
    return [defaults boolForKey:@"isShowAPNSPermissionReminder"];
}


- (void)setIsShowAPNSPermissionReminder:(BOOL)isNeed
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setBool:isNeed forKey:@"isShowAPNSPermissionReminder"];
    
    [defaults synchronize];
}



//isShowNotificationReminder
- (BOOL)isShowNotificationReminder
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![defaults objectForKey:@"isShowNotificationReminder"]) {
        
        // Default setting
        [defaults setBool:YES forKey:@"isShowNotificationReminder"];
        [defaults synchronize];
        
    }
    
    return [defaults boolForKey:@"isShowNotificationReminder"];
}


- (void)setIsShowNotificationReminder:(BOOL)isNeed
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setBool:isNeed forKey:@"isShowNotificationReminder"];
    
    [defaults synchronize];
}


//isShowContactsReminder
- (BOOL)isShowContactsReminder
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![defaults objectForKey:@"isShowContactsReminder"]) {
        
        // Default setting
        [defaults setBool:YES forKey:@"isShowContactsReminder"];
        [defaults synchronize];
        
    }
    
    return [defaults boolForKey:@"isShowContactsReminder"];
}


- (void)setIsShowContactsReminder:(BOOL)isNeed
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setBool:isNeed forKey:@"isShowContactsReminder"];
    
    [defaults synchronize];
}


//isContactsLoaded
- (BOOL)isContactsLoaded
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![defaults objectForKey:@"isContactsLoaded"]) {
        
        // Default setting
        [defaults setBool:NO forKey:@"isContactsLoaded"];
        [defaults synchronize];
        
    }
    
    return [defaults boolForKey:@"isContactsLoaded"];
}


- (void)setIsContactsLoaded:(BOOL)isNeed
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setBool:isNeed forKey:@"isContactsLoaded"];
    
    [defaults synchronize];
}







- (BOOL)isGroupEditing
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![defaults objectForKey:@"isGroupEditing"]) {
        
        // Default setting
        [defaults setBool:NO forKey:@"isGroupEditing"];
        [defaults synchronize];
        
    }
    
    return [defaults boolForKey:@"isGroupEditing"];
}


- (void)setIsGroupEditing:(BOOL)isEditing
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setBool:isEditing forKey:@"isGroupEditing"];
    
    [defaults synchronize];
}






//friendsGroupArray
/*
 
 每組都有以下內容
 
 friendsNum
 groupName


 
 */


- (NSMutableArray *)friendsGroupArray
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *mutableArray = [[NSMutableArray  alloc] init];
    
    if (![defaults objectForKey:@"friendsGroupArray"]) {
        
        mutableArray =  [NSMutableArray arrayWithObjects:nil];
        
        NSMutableDictionary *groupDictionary = [[NSMutableDictionary alloc] init];
        [groupDictionary setObject:[NSNumber numberWithInt:0] forKey:@"friendsNum"];
        [groupDictionary setObject:@"All" forKey:@"groupName"];
        [mutableArray addObject:groupDictionary];
        
        return mutableArray;
        
    }
    
    
    for(NSMutableArray *subarray in [defaults objectForKey:@"friendsGroupArray"]) {
        
        [mutableArray addObject: [subarray mutableCopy]];
    }
    
    return mutableArray;
    
}


- (void)setFriendsGroupArray:(NSMutableArray *)grouparray
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:grouparray forKey:@"friendsGroupArray"];
    
    [defaults synchronize];
    
    
    
}


//friendsGroup
- (int)friendsGroupIndex
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![defaults objectForKey:@"friendsGroupIndex"]) {
        
        return 0;
        
    }
    
    
    //防錯機制
    if ((int)[defaults integerForKey:@"friendsGroupIndex"] >= [[self friendsGroupArray] count]) {
        
        return 0;
        
    }
    
    
    return (int)[defaults integerForKey:@"friendsGroupIndex"];

    
    
    
    
}



- (void)setFriendsGroupIndex:(int)group
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setInteger:group forKey:@"friendsGroupIndex"];
    
    [defaults synchronize];
    
}





//closeFriendsNum
- (int)closeFriendsNum
{
    
    
  
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![defaults objectForKey:@"closeFriendsNum"]) {
        
        return 0;
        
    }
    
    return (int)[defaults integerForKey:@"closeFriendsNum"];
     


    
    
    
}



- (void)setCloseFriendsNum:(int)friendsNum
{
    
 
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setInteger:friendsNum forKey:@"closeFriendsNum"];
    
    [defaults synchronize];

    
    


    
}





//removeCloseFriendIndexArray
- (NSMutableArray *)removeCloseFriendIndexArray
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *mutableArray = [[NSMutableArray  alloc] init];
    
    
    if (![defaults objectForKey:@"removeCloseFriendIndexArray"]) {
        
        NSMutableArray *insideArray = [[NSMutableArray  alloc] init];
        insideArray =  [NSMutableArray arrayWithObjects:nil];

        [mutableArray addObject:insideArray];
        
        return mutableArray;
    }
    
    
   
    
    for(NSMutableArray *subarray in [defaults objectForKey:@"removeCloseFriendIndexArray"]) {
        
        [mutableArray addObject: [subarray mutableCopy]];
    }
    
    

    
    return mutableArray;
    
    
    
}

- (void)setRemoveCloseFriendIndexArray:(NSMutableArray *)contactsarray
{
    
    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    [defaults setObject:contactsarray forKey:@"removeCloseFriendIndexArray"];
    
    [defaults synchronize];
    

    
    
    
}





@end
