//
//  User.h
//  CustomChat
//
//  Created by Wilson Mora on 11/3/16.
//  Copyright © 2016 WilsonApps. All rights reserved.
//

#import <Foundation/Foundation.h>

#define USER_AVAILABILITY_PATH @"availability"
#define USER_PROFILE_IMAGE_PATH @"profile_image"
#define USER_STATUS_PATH @"status"
#define USERNAME_PATH @"username"

@interface User :NSObject

@property (weak, nonatomic) NSString *username;
@property (weak, nonatomic) NSString *userEmail;
@property (weak, nonatomic) NSString *userAvailability;
@property (weak, nonatomic) NSString *profileImage;
@property (weak, nonatomic) NSString *status;

+(NSString *)formatEmail:(NSString *)email;

@end
