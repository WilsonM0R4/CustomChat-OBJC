//
//  ProfileViewController.m
//  CustomChat
//
//  Created by Wilson Mora on 11/1/16.
//  Copyright © 2016 WilsonApps. All rights reserved.
//

#import "ProfileViewController.h"
#import "FirebaseHelper.h"

@interface ProfileViewController ()
- (IBAction)signOff:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *imageContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageview;

@end

@implementation ProfileViewController

NSMutableArray *sectionsArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.profileImageview.image = [self configureProfileImageView:nil];
	self.profileImageview.contentMode = UIViewContentModeScaleAspectFit;
	sectionsArray = [[NSMutableArray alloc] initWithArray:@[
															@{@"title":@"editar perfil",
															  @"image":@""
																},
															@{
																}]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIImage *)configureProfileImageView:(NSString *)profileImageName{
	
	UIImage *image;
	
	if(profileImageName!=nil){
		image = [UIImage imageNamed:profileImageName];
	}else{
		image = [UIImage imageNamed:@"profile_icon_9"];
	}
	
	return image;
	
}

#pragma mark tableView dataSource

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	
	
	return nil;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [sectionsArray count];
	
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)signOff:(id)sender {
		
	[[FirebaseHelper sharedInstance] signOff];
	[self dismissViewControllerAnimated:YES completion:nil];
}
@end
