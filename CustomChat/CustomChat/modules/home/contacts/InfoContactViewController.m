//
//  InfoContactViewController.m
//  CustomChat
//
//  Created by Wilson Mora on 12/5/16.
//  Copyright © 2016 WilsonApps. All rights reserved.
//

#import "InfoContactViewController.h"

@interface InfoContactViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)backAction:(id)sender;

@end

@implementation InfoContactViewController


NSMutableArray *dic;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	
	dic = [NSMutableArray arrayWithArray:@[@{@"title":@"email",@"subtitle":@""},@{@"title":@"estado", @"subtitle":@""},@{@"title":@"disponibilidad",@"subtitle":@""}]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender {
	
	[self dismissViewControllerAnimated:YES completion:nil];
	
}

#pragma mark tableVeiw dataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return 3;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contactItem"];
	
	
	
	return cell;
	
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
