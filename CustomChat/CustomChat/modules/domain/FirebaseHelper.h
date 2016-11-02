//
//  FirebaseHelper.h
//  CustomChat
//
//  Created by Wilson Mora on 11/1/16.
//  Copyright © 2016 WilsonApps. All rights reserved.
//

#import <Firebase/Firebase.h>
#import <Foundation/Foundation.h>

typedef void (^loginHandler)(BOOL);

@interface FirebaseHelper : NSObject

@property loginHandler handler;

+(id)sharedInstance;

-(void)launchAuthListener;
-(void)signInWithEmail:(NSString *)email andPassword:(NSString *)password loginHandler:(void (^)(BOOL)) handler;
-(void)signOff;
-(void)signUp;

@end
