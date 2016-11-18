//
//  ViewController.m
//  CustomChat
//
//  Created by Wilson Mora on 10/18/16.
//  Copyright © 2016 WilsonApps. All rights reserved.
//

#import "ViewController.h"
#import "HomeViewController.h"
#import "FirebaseHelper.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) UIBarButtonItem *buttonRegister;
- (IBAction)loginPressed:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	[[FirebaseHelper sharedInstance] setHandler: ^(BOOL logedIn){
		if(logedIn){
			[self launchHomeView];
		}
		
	}];
	
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


- (IBAction)loginPressed:(id)sender {
	
	NSString *email = self.tfEmail.text;
	NSString *password = self.tfPassword.text;
	
	NSLog(@"login pressed!, %@, %@", email, password);
		
	
	[[FirebaseHelper sharedInstance] signInWithEmail:email andPassword:password loginHandler:^(BOOL logedIn) {
		if(logedIn){
			[self launchHomeView];
		}else{
			NSLog(@"cannot present new view controller");
			UIAlertController *alertLogin = [UIAlertController alertControllerWithTitle:@"Datos incorrectos" message:@"sus datos son incorrectos, por favor verifiquelos e intentelo de nuevo" preferredStyle:UIAlertControllerStyleAlert];
			
			UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"entendido" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
				
				[alertLogin dismissViewControllerAnimated:YES completion:nil];
				
			}];
			
			[alertLogin addAction:actionOk];
			
			[self presentViewController:alertLogin animated:YES completion:nil];
		}
	}];
}



-(void)launchHomeView{
	HomeViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
	[self presentViewController:controller animated:YES completion:nil];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
	[self.view endEditing:YES];
}


@end
