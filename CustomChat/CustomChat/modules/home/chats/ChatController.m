//
//  ChatController.m
//  CustomChat
//
//  Created by Wilson Mora on 12/29/16.
//  Copyright © 2016 WilsonApps. All rights reserved.
//

#import "ChatController.h"
#import "MessageCell.h"
#import "FirebaseHelper.h"
#import "User.h"

@interface ChatController ()

@end

@implementation ChatController

NSString *reuseCellIdentifier;
NSArray *keys;
NSString *currentUser;
NSNull *null;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	null = [NSNull null];
	
	NSLog(@"chat is %@",self.chatDictionary);
	
	self.messagesTable.delegate = self;
	self.messagesTable.dataSource = self;
		
	
	reuseCellIdentifier = @"chatsCell";
	
	[self.messagesTable registerNib:[UINib nibWithNibName:@"MessageCell" bundle:nil] forCellReuseIdentifier:reuseCellIdentifier];
	
	currentUser = [User formatEmail:[[FirebaseHelper sharedInstance] getCurrentUser].email];	
	
	[self configNavigationBar];
	[self extractChatKeys:self.chatDictionary];
	
	NSLog(@"path in chat controller is: %@",self.chatPath);

	FirebaseHelper *helper = [FirebaseHelper sharedInstance];
	[helper listenForChatsWithChatPath:self.chatPath];
	
	helper.domainDelegate = self;
	
	
	
}

-(void)extractChatKeys:(NSDictionary *)chatDictionary{
	keys = [chatDictionary allKeys];
}

-(void)configNavigationBar{	
	self.navbarTitle.title = @"ChatController";
	self.navBarBackButton.title = @"volver";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonPressed:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sendPressed:(id)sender {
	
	
	
}

#pragma mark table datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return self.chatDictionary.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	MessageCell *cell = (MessageCell *)[tableView dequeueReusableCellWithIdentifier:reuseCellIdentifier];
	NSLog(@"keys array on index %ld contains: %@",indexPath.row,[keys objectAtIndex:indexPath.row]);
	
	[cell.messageLabel setText:[[_chatDictionary objectForKey:[keys objectAtIndex:indexPath.row]] objectForKey:@"content"]];
	cell.hourLabel.text = [[_chatDictionary objectForKey:[keys objectAtIndex:indexPath.row]] objectForKey:@"hour"];
	
	if([_chatDictionary[keys[indexPath.row]][@"sender"] isEqualToString:currentUser]){
		[cell configureCell:STYLE_USER];
		NSLog(@"style is %@",STYLE_USER);
	}else{
		[cell configureCell:STYLE_CONTACT];
		NSLog(@"style is %@",STYLE_CONTACT);
	}
	
	
	NSLog(@"key is %@",[keys objectAtIndex:indexPath.row]);
	NSLog(@"chat is %@",[_chatDictionary objectForKey:[keys objectAtIndex:indexPath.row]]);
	
	return cell;
}

#pragma mark DomainDelegate
-(void)onChatListenerResult:(NSMutableDictionary *)chat{
	
	NSLog(@"received response in delegate is: %@",chat);
	NSLog(@"count for received Chat is: %ld",chat.count);
	
	NSArray *tempKeys = [chat allKeys];
	
	keys = tempKeys;
	
	[self.chatDictionary removeAllObjects];
	
	for(int c=0; c<chat.count; c++){
		
		NSLog(@"on index %i",c);
		[self.chatDictionary setObject:[chat objectForKey:[tempKeys objectAtIndex:c]] forKey:[tempKeys objectAtIndex:c]];
	}
	
	[self.messagesTable reloadData];
	
}


@end
