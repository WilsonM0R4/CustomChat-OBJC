//
//  ChatsViewController.m
//  CustomChat
//
//  Created by Wilson Mora on 11/1/16.
//  Copyright © 2016 WilsonApps. All rights reserved.
//

#import "ChatsViewController.h"
#import "DateHelper.h"
#import "ChatTableViewCell.h"
#import "User.h"
#import "ChatController.h"

@interface ChatsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *chatsTable;
@property NSMutableDictionary *chatsDictionary;

@end

@implementation ChatsViewController

@synthesize chatsTable;

NSMutableDictionary *chats;
NSString *cellId;
NSMutableArray *chatPathKeys;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	chatsTable.delegate = self;
	chatsTable.dataSource = self;
	
	FirebaseHelper * helper = [FirebaseHelper sharedInstance];
	helper.domainDelegate = self;
	
	chats = [[NSMutableDictionary alloc] init];
	chatPathKeys = [[NSMutableArray alloc] init];
	
	cellId = @"chatsCell";
	
	[chatsTable registerNib:[UINib nibWithNibName:@"ChatTableViewCell" bundle:nil] forCellReuseIdentifier:cellId];
	
	[helper bringChats];
	NSLog(@"date is: %@",[DateHelper getExactDate]);
	
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark DomainDelegate

-(void)onChatsFound:(NSMutableDictionary *)foundChats{
	
	//NSNull *nullValue = [NSNull null];
	
	
	
	NSLog(@"delegate called");
	NSLog(@"chats in delegate :%@",foundChats);
	
	if(chats.count!=0){
		[chats removeAllObjects];
		NSLog(@"count < 0");
	}
	
	
	[chats setDictionary:foundChats];
	//[chats replaceObjectsInRange:NSMakeRange(0, chats.count) withObjectsFromArray:foundChats];
	NSLog(@"count in delegate is: %ld, found chats count is:%ld",chats.count,foundChats.count);
	[chatsTable reloadData];
	
	
	//NSArray *temp = [NSArray arrayWithArray:chats];
	
	
}

#pragma mark tableView datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	NSLog(@"count is: %ld",chats.count);
	return chats.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	NSArray *dic = [chats allKeys];
	NSArray *tempChatKeys = [[chats objectForKey:[dic objectAtIndex:indexPath.row]] allKeys];
	[chatPathKeys addObject:dic[0]];
	
	NSLog(@"temp chat keys: %@",tempChatKeys);
	
	NSDictionary *members = [User getChatMembersFromString:dic[indexPath.row] withCurrentUser:[[FirebaseHelper sharedInstance] getCurrentUser].email];
	
	
	ChatTableViewCell *tableViewCell = (ChatTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
	
	tableViewCell.title.text = members[CONTACT];
	tableViewCell.subtitle.text = [[[chats  objectForKey:dic[indexPath.row]] objectForKey:[tempChatKeys objectAtIndex:0]] objectForKey:@"content"];
	
	NSLog(@"temp key is: %@",dic[0]);
	
	NSLog(@"message is: %@",[[[chats objectForKey:dic[indexPath.row]] objectForKey:[tempChatKeys objectAtIndex:tempChatKeys.count-1]] objectForKey:@"content"] );
	
	NSLog(@"test message");
	return tableViewCell;
}

#pragma mark tableView delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
	NSArray *temp = [chats  allKeys];
	
	NSLog(@"contact is %@",chats[temp[indexPath.row]]);
	ChatController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ChatController"];
	
	controller.chatDictionary = [chats objectForKey:temp[indexPath.row]];
	controller.chatPath = [chatPathKeys objectAtIndex:indexPath.row];
	NSLog(@"chat path is: %@",[chatPathKeys objectAtIndex:indexPath.row]);
	NSLog(@"complete chat paths are: %@",chatPathKeys);
	
	[self presentViewController:controller animated:YES completion:nil];
	
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 90.0;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
