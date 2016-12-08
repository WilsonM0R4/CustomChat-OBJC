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


UIActivityIndicatorView *loader;
- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	loader = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	[loader setFrame:self.view.frame];
	[loader setHidden:NO];
	[loader setBackgroundColor:[UIColor grayColor]];
	
	
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

-(void)showLoader{
	[self.view addSubview:loader];
	[loader startAnimating];
}

-(void)hideLoader{
	[loader stopAnimating];
	[loader removeFromSuperview];
}

- (IBAction)loginPressed:(id)sender {
	
	NSString *email = self.tfEmail.text;
	NSString *password = self.tfPassword.text;
	
	NSLog(@"login pressed!, %@, %@", email, password);
	
	[self showLoader];
	
	[[FirebaseHelper sharedInstance] signInWithEmail:email andPassword:password loginHandler:^(BOOL logedIn) {
		if(logedIn){
			[self hideLoader];
			[self launchHomeView];
		}else{
			NSLog(@"cannot present new view controller");
			UIAlertController *alertLogin = [UIAlertController alertControllerWithTitle:@"Datos incorrectos" message:@"sus datos son incorrectos, por favor verifiquelos e intentelo de nuevo" preferredStyle:UIAlertControllerStyleAlert];
			
			UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"entendido" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
				
				[self hideLoader];
				
				[alertLogin dismissViewControllerAnimated:YES completion:nil];
				
			}];
			
			[alertLogin addAction:actionOk];
			
			[self presentViewController:alertLogin animated:YES completion:nil];
		
		}
	}];
}



-(void)launchHomeView{
	HomeViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
	[self.navigationController presentViewController:controller animated:YES completion:nil];	
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
	[self.view endEditing:YES];
}


@end
