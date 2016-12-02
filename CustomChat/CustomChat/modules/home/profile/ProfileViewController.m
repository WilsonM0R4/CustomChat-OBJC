//
//  ProfileViewController.m
//  CustomChat
//
//  Created by Wilson Mora on 11/1/16.
//  Copyright © 2016 WilsonApps. All rights reserved.
//

#import "ProfileViewController.h"
#import "FirebaseHelper.h"
#import "User.h"
#import "EditProfileViewController.h"

@interface ProfileViewController ()
- (void)signOff;
@property (weak, nonatomic) IBOutlet UIView *imageContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageview;
@property (weak, nonatomic) IBOutlet UITableView *tableProfile;
@property (weak, nonatomic) IBOutlet UILabel *userEmailLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;

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

-(void)viewWillAppear:(BOOL)animated{
	self.userEmailLabel.text = [[FirebaseHelper sharedInstance] getCurrentUser].email;
	self.stateLabel.text = [[FirebaseHelper sharedInstance] getCurrentUserState];
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
	
	NSLog(@"formated email is %@", [User formatEmail:[[FIRAuth auth] currentUser].email]);
	
	EditProfileViewController *editProfileController = [self.storyboard instantiateViewControllerWithIdentifier:@"EditProfileViewController"];
	
	[self presentViewController:editProfileController animated:YES completion:nil];
}

-(void)changheUserState{
	
	
	UIAlertController *statusAlert = [UIAlertController alertControllerWithTitle:@"estado" message:@"digita un estado" preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction *actionSend = [UIAlertAction actionWithTitle:@"send" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		NSLog(@"send pressed");
		
		NSString *status = [statusAlert textFields][0].text;
		NSString *formatedEmail = [User formatEmail:[[FirebaseHelper sharedInstance] getCurrentUser].email];
		
		[[FirebaseHelper sharedInstance ] changeUserState:status forUserWithEmail:formatedEmail];
		
		[statusAlert dismissViewControllerAnimated:YES completion:nil];
	}];
	
	UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		NSLog(@"cancel pressed");
		[statusAlert dismissViewControllerAnimated:YES completion:nil];
	}];
	
	[statusAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
		textField.placeholder = @"estado";
	}];
	
	[statusAlert addAction:actionCancel];
	[statusAlert addAction:actionSend];
	
	[self presentViewController:statusAlert animated:YES completion:nil];
	
}

-(void)changeAvailability{
	
	NSString *formatedEmail = [User formatEmail:[[FirebaseHelper sharedInstance] getCurrentUser].email];
	FIRDatabaseReference *reference = [[[[[FirebaseHelper sharedInstance] getDatabaseReference] child:USER_EXTRA_DATA_PATH] child:formatedEmail] child:USER_AVAILABILITY_PATH];
	
	UIAlertController *availabilityAlert = [UIAlertController alertControllerWithTitle:@"estado" message:@"digita un estado" preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction *actionSend = [UIAlertAction actionWithTitle:@"conectado" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		
		[reference setValue:@"online"];
			
		[availabilityAlert dismissViewControllerAnimated:YES completion:nil];
	}];
	
	UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"desconectado" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		
		[reference setValue:@"offline"];
		
		[availabilityAlert dismissViewControllerAnimated:YES completion:nil];
	}];
	
	[availabilityAlert addAction:actionCancel];
	[availabilityAlert addAction:actionSend];
	
	[self presentViewController:availabilityAlert animated:YES completion:nil];
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
			[self changheUserState];
			break;
		case 2:
			NSLog(@"availability selected!");
			[self changeAvailability];
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
