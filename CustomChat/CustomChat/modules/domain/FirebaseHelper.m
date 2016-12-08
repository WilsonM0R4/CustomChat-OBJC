//
//  FirebaseHelper.m
//  CustomChat
//
//  Created by Wilson Mora on 11/1/16.
//  Copyright © 2016 WilsonApps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FirebaseHelper.h"
#import "User.h"
#import "ContactsViewController.h"
#import "InfoContactViewController.h"

@implementation FirebaseHelper

@synthesize handler, response;

+(id)sharedInstance{
	
	static FirebaseHelper *helper = nil;
	static dispatch_once_t onceInstance;
	dispatch_once(&onceInstance, ^{
		helper = [[self alloc] init];
	});
	return helper;
}

-(id)init{
	response = [[NSMutableDictionary alloc] init];
	return self;
}

-(void)launchAuthListener{
	
	[[FIRAuth auth] addAuthStateDidChangeListener:^(FIRAuth * _Nonnull auth, FIRUser * _Nullable user) {
		
		if(user!=nil){
			NSLog(@"user loged in!, is %@",[user email]);
			
			[self launchDatabaseListener];
			
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

-(void)launchDatabaseListener{
	
	NSLog(@"formated email is %@", [User formatEmail:[[FIRAuth auth] currentUser].email]);
	[[[[[FirebaseHelper sharedInstance] getDatabaseReference] child:USER_EXTRA_DATA_PATH] child:[User formatEmail:[[FIRAuth auth] currentUser].email]] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
		//response = snapshot.value;
		[response setDictionary:snapshot.value];
		
		NSLog(@"response is %@",response);
		
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
			NSLog(@"an error have occurred, it is %@",error);
			if(loginHandler!=nil){
				loginHandler(NO);
			}
		}
		
	}];
}

-(FIRDatabaseReference *)getDatabaseReference{
	return [[FIRDatabase database] reference];
}

-(FIRUser *)getCurrentUser{
	return [FIRAuth auth].currentUser;
}

-(NSString *)getCurrentUserState{
	
	/*[[[[self getDatabaseReference] child:USER_EXTRA_DATA_PATH] child:[User formatEmail:[FIRAuth auth].currentUser.email]] child:USER_STATUS_PATH];*/
	
	[[[[[FirebaseHelper sharedInstance] getDatabaseReference] child:USER_EXTRA_DATA_PATH] child:[User formatEmail:[[FIRAuth auth] currentUser].email]] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
		//response = snapshot.value;
		[response setDictionary:snapshot.value]; 				
		
	}];
	
	NSLog(@"state here  is %@",response[USER_STATUS_PATH]);
	return response[USER_STATUS_PATH];
}

-(void)getExtraDataForUser:(NSString *)user{
	
	NSLog(@"contact is %@",user);
	
	[[[[self getDatabaseReference] child:USER_EXTRA_DATA_PATH] child:[User formatEmail:user] ] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
		
		NSLog(@"extra data is %@",snapshot.value);
		
		if([self.domainDelegate respondsToSelector:@selector(onExtraDataFound: forUserEmail:)]){
			[_domainDelegate onExtraDataFound:snapshot.value forUserEmail:user];
		}
		
	}];
	
}

-(void)bringContacts{
	
	NSMutableArray *contacts = [[NSMutableArray alloc] init];
	
	[[[[[FirebaseHelper sharedInstance] getDatabaseReference] child:CONTACTS_PATH] child:[User formatEmail:[[FIRAuth auth] currentUser].email]] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
		
		[contacts addObjectsFromArray: [snapshot.value allValues]];
		
		//[ContactsViewController onContactsFound:[snapshot.value allValues]];
		
		if([_domainDelegate respondsToSelector:@selector(onContactsFound:)]){
			[_domainDelegate onContactsFound:contacts];
			NSLog(@"delegate responds to selector");
		}else{
			NSLog(@"delegate does not responds to selector");
		}
		NSLog(@"contacts are %@",contacts);
	}];
	
	NSLog(@"contacts here are %@",contacts);
	
}

-(void)changeUserState:(NSString *)userState forUserWithEmail:(NSString *)email{
	
	[[[[[self getDatabaseReference] child:USER_EXTRA_DATA_PATH] child:email] child:USER_STATUS_PATH] setValue:userState] ;
	
}

-(void)changeUsername:(NSString *)username forUserWithEmail:(NSString *)email{
	[[[[[self getDatabaseReference] child:USER_EXTRA_DATA_PATH] child:email] child:USERNAME_PATH] setValue:username] ;
}

-(void)changePassword:(NSString *)password {
	[[[FIRAuth auth] currentUser] updatePassword:password completion:^(NSError * _Nullable error) {
		if(error){
			NSLog(@"can't change your password");
		}else{
			NSLog(@"password changed");
		}
	}];
}

-(void)removeContact:(NSString *)contact{
	
	NSString* contactPath = [CONTACT_KEY_STRING stringByAppendingString:contact];
	
	[[[[[self getDatabaseReference] child: CONTACTS_PATH]child:[User formatEmail:[[FIRAuth auth] currentUser].email]] child:contactPath] setValue:nil withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
		
		if(error!=nil){
			NSLog(@"somethig went wrong, cannot remove contact: %@",error.userInfo);
		}else if(ref!=nil){
			NSLog(@"contact has been removed");
			
			if([_domainDelegate respondsToSelector:@selector(onContactRemoved)]){
				[self.domainDelegate onContactRemoved];
			}
		}
		
	}] ;
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
