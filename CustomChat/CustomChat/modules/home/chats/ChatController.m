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
#import "ArrayManager.h"
#import "DateHelper.h"

@interface ChatController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@end

@implementation ChatController

NSString *reuseCellIdentifier;
NSMutableArray *keys;
NSString *currentUser;
NSNull *null;
NSMutableArray *chatArray;
float constraintValue;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	null = [NSNull null];
	
	NSLog(@"chat is %@",self.chatDictionary);
	
	chatArray = [[NSMutableArray alloc] init];
	keys = [[NSMutableArray alloc] init];
	
	//chatArray = [[ArrayManager compareAndOrganizeDictionaryWithNumericKeys:self.chatDictionary] mutableCopy];
	
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
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardShown:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardHiden) name:UIKeyboardWillHideNotification object:nil];
	
}

-(void)viewDidAppear:(BOOL)animated{
	NSIndexPath* indexPath = [NSIndexPath indexPathForRow:_chatDictionary.count-1 inSection:0];
	[self.messagesTable scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

-(void)extractChatKeys:(NSDictionary *)chatDictionary{
	keys = [[chatDictionary allKeys] mutableCopy];
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
	
	[self.view endEditing:YES];
	NSString *messageTyped = self.messageTextField.text;
	NSString *chatKey = [DateHelper getExactDate];
	NSString *date = [DateHelper getDate];
	NSString *hour = [DateHelper getHour];
	NSString *senderMail = [User formatEmail:[[FirebaseHelper sharedInstance] getCurrentUser].email];
	
	NSLog(@"messageTyped is: %@, \n chatKey is: %@ \n date is %@: \n hour is: %@ \n sender mail is: %@\n",messageTyped,chatKey,date,hour,senderMail);
	
	NSDictionary *messageDic = @{ chatKey:@{
										  
										  @"content":	messageTyped,
										  @"date":	date,
										  @"hour":	hour,
										  @"sender":	senderMail
										  
										  }																
								 };
	
	[[FirebaseHelper sharedInstance] sendMessage:messageDic forConversation:self.chatPath];
	self.messageTextField.text = @"";
	
}


-(void)onKeyboardShown:(NSNotification *)notification{

	CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
	
	//animation is not working now
	
	[UIView animateWithDuration:10.0 animations:^{
		
		constraintValue = _bottomConstraint.constant;
		_bottomConstraint.constant = keyboardSize.height;
		
	}];
	
	
	
	NSLog(@"keyboard is on screen");
	
}

-(void)onKeyboardHiden{
	
	//animation is not working now
	
	[UIView animateWithDuration:10.0 animations:^{
	
		_bottomConstraint.constant = constraintValue;
		
	}];
	
	
	NSLog(@"keyboard is hidden");
}

#pragma mark table datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return self.chatDictionary.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	/** DATA **/
	//NSString * keyInPosition = [[[chatArray objectAtIndex:indexPath.row] allKeys] objectAtIndex:0];
	//NSLog(@"key in position is: %@",keyInPosition);
	
	
	MessageCell *cell = (MessageCell *)[tableView dequeueReusableCellWithIdentifier:reuseCellIdentifier];
	
	cell.messageLabel.text = [[_chatDictionary objectForKey:[keys objectAtIndex:indexPath.row]] objectForKey:@"content"];
	
	if([[[_chatDictionary objectForKey:[keys objectAtIndex:indexPath.row]] objectForKey:@"date"] isEqualToString:[DateHelper getDate]]){
		cell.hourLabel.text = [[_chatDictionary objectForKey:[keys objectAtIndex:indexPath.row]] objectForKey:@"hour"];
	}else{
		cell.hourLabel.text = [[_chatDictionary objectForKey:[keys objectAtIndex:indexPath.row]] objectForKey:@"date"];
	}
	
	
	
	NSLog(@"message at indexpath %ld is %@",indexPath.row,cell.messageLabel.text);
	
	if([_chatDictionary[keys[indexPath.row]][@"sender"]isEqualToString:[User formatEmail:currentUser]]
	   ||[_chatDictionary[keys[indexPath.row]][@"sender"] isEqualToString:currentUser] ){
		
		[cell configureCell:STYLE_USER];
		NSLog(@"style is %@",STYLE_USER);
	}else{
		[cell configureCell:STYLE_CONTACT];
		NSLog(@"style is %@",STYLE_CONTACT);
	}
	
	//NSLog(@"message in this position is %@",[[[chatArray objectAtIndex:indexPath.row] objectForKey:keyInPosition] objectForKey:@"content"]);
	//NSLog(@"keys array on index %ld contains: %@",indexPath.row,[keys objectAtIndex:indexPath.row]);
	/*cell.messageLabel.text = [[chatArray objectAtIndex:indexPath.row] objectForKey:@"content"];
	 cell.hourLabel.text = [[chatArray objectAtIndex:indexPath.row] objectForKey:@"hour"];*/
	//NSLog(@"key is %@",[keys objectAtIndex:indexPath.row]);
	//NSLog(@"chat is %@",[_chatDictionary objectForKey:[keys objectAtIndex:indexPath.row]]);
	
	return cell;
}

#pragma mark DomainDelegate
-(void)onChatListenerResult:(NSMutableDictionary *)chat{
	
	NSLog(@"received response in delegate is: %@",chat);
	NSLog(@"count for received Chat is: %ld",chat.count);
	
	NSArray *tempKeys = [chat allKeys];
	
	tempKeys = [tempKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
	
		return [obj1 compare:obj2];
		
	}];
	
	NSLog(@"chat keys are %@",tempKeys);
	
	if(keys.count >0){
		[keys removeAllObjects];
		NSLog(@"keys had been removed");
	}
	
	if(self.chatDictionary.count >0){
		[self.chatDictionary removeAllObjects];
	}
		
	[keys addObjectsFromArray:tempKeys];
	
	[_chatDictionary setDictionary:chat];
	
	NSLog(@"chats dictionary copied is: %@",_chatDictionary);
	
	NSLog(@"attempt to reload data");
	[self.messagesTable reloadData];
	NSLog(@"data reloaded");
	
	NSIndexPath* indexPath = [NSIndexPath indexPathForRow:_chatDictionary.count-1 inSection:0];
	[self.messagesTable scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
	
}


@end
