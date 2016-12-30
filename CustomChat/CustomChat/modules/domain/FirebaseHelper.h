//
//  FirebaseHelper.h
//  CustomChat
//
//  Created by Wilson Mora on 11/1/16.
//  Copyright © 2016 WilsonApps. All rights reserved.
//

#import <Firebase/Firebase.h>
#import <Foundation/Foundation.h>

#define	USER_EXTRA_DATA_PATH @"user_extra_data"
#define CONTACTS_PATH @"contacts"
#define CONTACT_KEY_STRING @"contact_key_"

typedef void (^loginHandler)(BOOL);

@protocol DomainProtocol <NSObject>

@optional

-(void)onContactsFound:(NSArray *)foundContacts;
-(void)onExtraDataFound:(NSDictionary *)extraData forUserEmail:(NSString *)email;
-(void)onContactRemoved:(NSInteger)index;
-(void)onUserFound:(NSDictionary *)foundUserData;
-(void)onChatsFound:(NSMutableArray *)foundChats;

@end

@interface FirebaseHelper : NSObject

@property loginHandler handler;
@property NSMutableDictionary *response;
@property id <DomainProtocol> domainDelegate;

+(id)sharedInstance;

-(void)launchAuthListener;
-(void)launchDatabaseListener;
-(void)signInWithEmail:(NSString *)email andPassword:(NSString *)password loginHandler:(void (^)(BOOL)) handler;
-(FIRDatabaseReference *)getDatabaseReference;
-(FIRUser *)getCurrentUser;
-(NSString *)getCurrentUserState;
-(void)searchUser:(NSString *)userEmail;
-(void)addContact:(NSString *)contactEmail;
-(void)getExtraDataForUser:(NSString *)user;
-(void)bringContacts;
-(void)bringChats;
-(void)changeUserState:(NSString *)userState forUserWithEmail:(NSString *)email;
-(void)changeUsername:(NSString *)username forUserWithEmail:(NSString *)email;
-(void)changePassword:(NSString *)password;
-(void)removeContact:(NSString *)contact;
-(void)signOff;
-(void)signUp;

@end
