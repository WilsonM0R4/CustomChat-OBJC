//
//  HomeViewController.m
//  CustomChat
//
//  Created by Wilson Mora on 11/1/16.
//  Copyright © 2016 WilsonApps. All rights reserved.
//

#import "HomeViewController.h"
#import "ChatsViewController.h"
#import "ContactsViewController.h"
#import "ProfileViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	
	//[self setTabBarItems];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)setTabBarItems{
	NSMutableArray *tabArray = [[NSMutableArray alloc] init];
	
	ProfileViewController *profileController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
	ChatsViewController *chatsController = [self.storyboard instantiateViewControllerWithIdentifier:@"ChatsViewController"];
	ContactsViewController *contactsController = [self.storyboard instantiateViewControllerWithIdentifier:@"ContactsViewController"];
	
	[tabArray addObjectsFromArray:@[chatsController,contactsController,profileController]];
	//[self.tabBarController setViewControllers:tabArray animated:YES];
	[self.tabBarController.viewControllers arrayByAddingObjectsFromArray:tabArray];
	
	chatsController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"chats" image:[UIImage imageNamed:@""] tag:10];
	contactsController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"contacts" image:[UIImage imageNamed:@""] tag:11];
	profileController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"profile" image:[UIImage imageNamed:@""] tag:12];

	
	return tabArray;
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
