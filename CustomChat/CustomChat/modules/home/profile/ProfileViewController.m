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
- (void)signOff;
@property (weak, nonatomic) IBOutlet UIView *imageContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageview;
@property (weak, nonatomic) IBOutlet UITableView *tableProfile;

@end

@implementation ProfileViewController

NSMutableArray *sectionsArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	_tableProfile.delegate = self;
	_tableProfile.dataSource = self;
	
	self.profileImageview.image = [self configureProfileImageView:nil];
	self.profileImageview.contentMode = UIViewContentModeScaleAspectFit;
	sectionsArray = [[NSMutableArray alloc] initWithArray:@[
															@{@"title":@"editar perfil", @"image":@"ic_mode_edit"},
															@{@"title":@"estado",@"image":@"ic_insert_emoticon"},
															@{@"title":@"disponibilidad",@"image":@"ic_person"},
															@{@"title":@"cerrar sesión",@"image":@"ic_exit_to_app"}]];
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

-(void)editProfile{
		
	[[[FirebaseHelper sharedInstance] getDatabaseReference] child:@""];
}

- (void)signOff {
	
	[[FirebaseHelper sharedInstance] signOff];
	[self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark tableView delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"profileCellItem"];
	
	UIImageView *imageView = [cell imageView];
	UILabel *textView = [cell textLabel];
	
	NSLog(@"view must be created");
	cell.imageView.image = [UIImage imageNamed:[[sectionsArray objectAtIndex:indexPath.row] objectForKey:@"image"]];
	cell.textLabel.text = [[sectionsArray objectAtIndex:indexPath.row] objectForKey:@"title"];
	
	NSLog(@"title for cell % lis %@",(long)indexPath.row,[[sectionsArray objectAtIndex:indexPath.row] objectForKey:@"title"]);
	
	[cell addSubview:imageView];
	[cell addSubview:textView];
	[cell setTag:indexPath.row];
	
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
	switch (indexPath.row) {
		case 0:
			NSLog(@"edit profile selected!");
			[self editProfile];
			break;
		case 1:
			NSLog(@"user state selected!");
			break;
		case 2:
			NSLog(@"availability selected!");
			break;
		case 3:
			NSLog(@"sign out selected!");
			[self signOff];
			break;
  default:
			break;
	}
	
}

#pragma mark tableView dataSource
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


@end
