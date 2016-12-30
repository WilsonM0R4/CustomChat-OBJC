//
//  User.h
//  CustomChat
//
//  Created by Wilson Mora on 11/3/16.
//  Copyright © 2016 WilsonApps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define USER_AVAILABILITY_PATH @"availability"
#define USER_PROFILE_IMAGE_PATH @"profile_image"
#define USER_STATUS_PATH @"status"
#define USERNAME_PATH @"username"
#define CONTACTS_PATH @"contacts"
#define CHATS_PATH @"chats"
#define CONTACT @"contact"
#define CURRENT_USER @"currentUser"

@interface User :NSObject

@property (weak, nonatomic) NSString *username;
@property (weak, nonatomic) NSString *userEmail;
@property (weak, nonatomic) NSString *userAvailability;
@property (weak, nonatomic) NSString *profileImage;
@property (weak, nonatomic) NSString *status;

+(NSString *)formatEmail:(NSString *)email;
+(void)showLoader:(UIActivityIndicatorView *)indicatorView inView:(UIView *)parentView;
+(void)hideLoader:(UIActivityIndicatorView *)indicatorView;
+(NSString *)makeContactPath:(NSString *)contactEmail;
+(NSDictionary *)getChatMembersFromString:(NSString *)chatString withCurrentUser:(NSString *)currentUser;

@end
