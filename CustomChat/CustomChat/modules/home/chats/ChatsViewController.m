//
//  ChatsViewController.m
//  CustomChat
//
//  Created by Wilson Mora on 11/1/16.
//  Copyright © 2016 WilsonApps. All rights reserved.
//

#import "ChatsViewController.h"

@interface ChatsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *chatsTable;
@property NSMutableDictionary *chatsDictionary;

@end

@implementation ChatsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.chatsTable.delegate = self;
	self.chatsTable.dataSource = self;
	
	[[FirebaseHelper sharedInstance] bringChats];
	
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark DomainDelegate



#pragma mark tableView datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return self.chatsDictionary.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	return nil;
}

#pragma mark tableView delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
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
