//
//  EditProfileViewController.m
//  CustomChat
//
//  Created by Wilson Mora on 11/8/16.
//  Copyright © 2016 WilsonApps. All rights reserved.
//

#import "EditProfileViewController.h"

@interface EditProfileViewController ()
- (IBAction)acceptPressed:(id)sender;
- (IBAction)cancelPressed:(id)sender;

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelPressed:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
}
@end
