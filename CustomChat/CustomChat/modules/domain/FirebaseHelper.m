//
//  FirebaseHelper.m
//  CustomChat
//
//  Created by Wilson Mora on 11/1/16.
//  Copyright © 2016 WilsonApps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FirebaseHelper.h"

@implementation FirebaseHelper

@synthesize handler;

+(id)sharedInstance{
	
	static FirebaseHelper *helper = nil;
	static dispatch_once_t onceInstance;
	dispatch_once(&onceInstance, ^{
		helper = [[self alloc] init];
	});
	return helper;
}

-(id)init{	
	return self;
}

-(void)launchAuthListener{
	[[FIRAuth auth] addAuthStateDidChangeListener:^(FIRAuth * _Nonnull auth, FIRUser * _Nullable user) {
		
		if(user!=nil){
			NSLog(@"user loged in!, is %@",[user email]);
			if(handler!=nil){
				handler(YES);
			}
		}else{
			
			NSLog(@"no user singed in");
			if(handler!=nil){
				handler(NO);
			}
			
			
		}
		
	}];
}

-(void)signUp{

}

-(void)signInWithEmail:(NSString *)email andPassword:(NSString *)password loginHandler:(void (^)(BOOL)) loginHandler{
	
	NSLog(@"attempting to execute login ...");
	
	[[FIRAuth auth] signInWithEmail:email password:password completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
		
		if(user!=nil){
			NSLog(@"user signed in is %@", [user email]);
			
			if(loginHandler!=nil){
				loginHandler(YES);
			}
			
			}else if(error!=nil){
			NSLog(@"an eror have occurred, it is %@",error);
		}
		
	}];
}

-(FIRDatabaseReference *)getDatabaseReference{
	return [[FIRDatabase database] reference];
}

-(FIRUser *)getCurrentUser{
	return [FIRAuth auth].currentUser;
}

-(void)signOff{
	NSError *error;
	[[FIRAuth auth] signOut:&error];
	if(!error){
		NSLog(@"loged out successfuly");
	}else{
		NSLog(@"some error have ocurred %@",error );	
	}
}

@end
