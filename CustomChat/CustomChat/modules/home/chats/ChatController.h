//
//  ChatController.h
//  CustomChat
//
//  Created by Wilson Mora on 12/29/16.
//  Copyright © 2016 WilsonApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property NSDictionary *chatDictionary;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UINavigationItem *navbarTitle;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *navBarBackButton;

@property (weak, nonatomic) IBOutlet UITableView *messagesTable;
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;

- (IBAction)backButtonPressed:(id)sender;
- (IBAction)sendPressed:(id)sender;

@end
