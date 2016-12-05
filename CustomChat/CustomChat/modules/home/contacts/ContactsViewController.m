//
//  ContactsViewController.m
//  CustomChat
//
//  Created by Wilson Mora on 11/1/16.
//  Copyright © 2016 WilsonApps. All rights reserved.
//

#import "ContactsViewController.h"
#import "InfoContactViewController.h"

@interface ContactsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *contactsTableView;

@end

@implementation ContactsViewController

@synthesize contactsTableView;

NSMutableArray* contacts;

- (void)viewDidLoad {
    [super viewDidLoad];
	//test = @[@"hello",@"world"];
	self.contactsTableView.delegate = self;
	self.contactsTableView.dataSource = self;
	FirebaseHelper *helper = [FirebaseHelper sharedInstance];
	helper.domainDelegate = self;
	
	contacts = [[NSMutableArray alloc] init];
	[[FirebaseHelper sharedInstance] bringContacts];
	NSLog(@"received contacts :%@",contacts);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)contactAlertSheetWithTitle:(NSString *)title{
	
	UIAlertController *controller = [UIAlertController alertControllerWithTitle:title message:@"¿que deseas hacer?" preferredStyle:UIAlertControllerStyleActionSheet];
	
	UIAlertAction *actionView = [UIAlertAction actionWithTitle:@"ver" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		
		NSLog(@"ver ha sido presionado");
		[controller dismissViewControllerAnimated:YES completion:nil];
		
		InfoContactViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"contactDetailVC"];
		
		[self presentViewController:viewController animated:YES completion:nil];
	}];
	
	UIAlertAction *actionNewMesage = [UIAlertAction actionWithTitle:@"mensaje" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		NSLog(@"mensaje ha sido presionado");
		[controller dismissViewControllerAnimated:YES completion:nil];
	}];
	
	UIAlertAction *actionDelete = [UIAlertAction actionWithTitle:@"eliminar" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
		
		NSLog(@"eliminar ha sido presionado");
		[controller dismissViewControllerAnimated:YES completion:nil];
	}];
	
	[controller addAction:actionView];
	[controller addAction:actionNewMesage];
	[controller addAction:actionDelete];
	
	[self presentViewController:controller animated:YES completion:nil];
	
}

-(void)searchContactAlert{
	UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Buscar" message:@"digita el correo de un usuario para buscarlo" preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction *actionSearch = [UIAlertAction actionWithTitle:@"buscar" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		NSLog(@"has presionado buscar");
		[controller dismissViewControllerAnimated:YES completion:nil];
	}];
	
	UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"cancelar" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
		NSLog(@"has presionado cancelar");
		[controller dismissViewControllerAnimated:YES completion:nil];
	}];
	
	[controller addAction:actionSearch];
	[controller addAction:actionCancel];
	
	[self presentViewController:controller animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark DomainDelegate

-(void)onContactsFound:(NSArray *)foundContacts{
	[contacts addObjectsFromArray:foundContacts];
	[contactsTableView reloadData];
	NSLog(@"found contacts %@",foundContacts);
}

#pragma mark tableView datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [contacts count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell"];
	cell.textLabel.text = contacts[indexPath.row];
	return cell;
}
#pragma mark tableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	[self contactAlertSheetWithTitle:[tableView cellForRowAtIndexPath:indexPath].textLabel.text];
}


@end
