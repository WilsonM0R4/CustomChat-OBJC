//
//  ChatController.m
//  CustomChat
//
//  Created by Wilson Mora on 12/29/16.
//  Copyright © 2016 WilsonApps. All rights reserved.
//

#import "ChatController.h"
#import "MessageCell.h"

@interface ChatController ()

@end

@implementation ChatController

NSString *reuseCellIdentifier;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSLog(@"chat is %@",self.chatDictionary);
	
	self.messagesTable.delegate = self;
	self.messagesTable.dataSource = self;
		
	
	reuseCellIdentifier = @"chatsCell";
	
	[self.messagesTable registerNib:[UINib nibWithNibName:@"MessageCell" bundle:nil] forCellReuseIdentifier:reuseCellIdentifier];
	
	[self configNavigationBar];
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
	
	cell.messageLabel.text = @"Mensaje";
	cell.hourLabel.text = @"hora de envio";
	
	return cell;
}


@end
