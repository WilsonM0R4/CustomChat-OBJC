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


NSNull *nullValue;

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
	
	nullValue = [NSNull null];
	
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

-(void)searchUser:(NSString *)userEmail{
	[[[[self getDatabaseReference] child:USER_EXTRA_DATA_PATH] child:[User formatEmail:userEmail]] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
		
		NSMutableDictionary *contactData = snapshot.value;
		
		if(snapshot.value!=nullValue){
			NSLog(@"contact exists, and the data is: %@",contactData);
			if([_domainDelegate respondsToSelector:@selector(onUserFound:)]){
				[contactData setObject:userEmail forKey:@"email"];
				[self.domainDelegate onUserFound:contactData];
			}else{
				NSLog(@"delegate does not respond to selector");
			}
		}else{
			NSLog(@"contact does not exists");
		}
		
	} ];
}

-(void)addContact:(NSString *)contactEmail{
	
	NSDictionary *data = @{[User makeContactPath:contactEmail]:contactEmail};
	
	FIRDatabaseReference *database = [[[self getDatabaseReference] child:CONTACTS_PATH] child:[User formatEmail:[FIRAuth auth].currentUser.email]];
	[database updateChildValues:data];
	[database observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
		NSDictionary *resp = snapshot.value;
		
		NSLog(@"response is %@",resp);
		
	}];
	
}

-(void)bringContacts{
	
	NSMutableArray *contacts = [[NSMutableArray alloc] init];
	
	[[[[[FirebaseHelper sharedInstance] getDatabaseReference] child:CONTACTS_PATH] child:[User formatEmail:[[FIRAuth auth] currentUser].email]] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
		
		[contacts removeAllObjects];
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

-(void)bringChats{
	
	NSMutableArray *foundChats = [[NSMutableArray alloc] init];
	
	FIRDatabaseReference *reference = [[self getDatabaseReference] child:CHATS_PATH];
	
	[reference observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
		NSLog(@"found data is %@",snapshot.value);
		
		[foundChats removeAllObjects];
		
		
		NSDictionary *data = snapshot.value;
		NSArray *tempKeys = [data allKeys];
		
		for(int c=0;c<tempKeys.count ;c++){
			
			NSRange range = [[tempKeys objectAtIndex:c] rangeOfString:[User formatEmail:[FIRAuth auth].currentUser.email]];
			NSLog(@"range is %lu",(unsigned long)range.length);
			
			if(range.length!= 0){
				[foundChats addObject:@{[tempKeys objectAtIndex:c]:[data objectForKey:tempKeys[c]]}];
			}else{
				NSLog(@"this chat does not correspond to current user");
			}
		}
		
		if([_domainDelegate respondsToSelector:@selector(onChatsFound:)] ){
			[self.domainDelegate onChatsFound:foundChats];
		}else{
			NSLog(@"not responding to selector (onChatsfound:)");
		}

		NSLog(@"found %@",foundChats);
		
	}];
	
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
			
			if([_domainDelegate respondsToSelector:@selector(onContactRemoved:)]){
				[self.domainDelegate onContactRemoved:0];
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
