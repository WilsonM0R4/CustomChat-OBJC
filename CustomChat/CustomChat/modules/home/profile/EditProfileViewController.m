//
//  EditProfileViewController.m
//  CustomChat
//
//  Created by Wilson Mora on 11/8/16.
//  Copyright © 2016 WilsonApps. All rights reserved.
//

#import "EditProfileViewController.h"
#import "FirebaseHelper.h"
#import "User.h"

@interface EditProfileViewController ()
- (IBAction)acceptPressed:(id)sender;
- (IBAction)cancelPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UITextField *stateField;
@property (weak, nonatomic) IBOutlet UILabel *changePassLabel;
- (IBAction)enablePassFields:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *passFieldsContainer;
@property (weak, nonatomic) IBOutlet UITextField *passField;
@property (weak, nonatomic) IBOutlet UITextField *pasConfirmField;

@end

@implementation EditProfileViewController

BOOL passEnabled;

- (void)viewDidLoad {
    [super viewDidLoad];
	self.passFieldsContainer.userInteractionEnabled = NO;
	
	
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)acceptPressed:(id)sender {

	if(![self.usernameField.text isEqualToString:@""] && ![self.stateField.text isEqualToString:@""]){
		[[FirebaseHelper sharedInstance] changeUsername:_usernameField.text forUserWithEmail:[User formatEmail:[[FirebaseHelper sharedInstance] getCurrentUser].email]];
		
		[[FirebaseHelper sharedInstance] changeUserState:_stateField.text forUserWithEmail:[User formatEmail:[[FirebaseHelper sharedInstance] getCurrentUser].email]];
		
	}else{
		NSLog(@"verifica tus datos");
	}
	
	if(passEnabled){
		if(self.passField.text !=nil && self.pasConfirmField.text!=nil){
			[[FirebaseHelper sharedInstance] changePassword:_passField.text];
		}else{
			NSLog(@"verifica tu contraseña");
		}
	}

	
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelPressed:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)enablePassFields:(id)sender {

	passEnabled = [sender isOn];
	
	if(passEnabled){

		self.passFieldsContainer.userInteractionEnabled = YES;
		NSLog(@"can edit");
	}else{
		self.passFieldsContainer.userInteractionEnabled = NO;
		NSLog(@"can't edit");
	}
	
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
	[self.view endEditing:YES];
}

#pragma mark tableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
}

#pragma mar tableView dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	return nil;
}

@end
