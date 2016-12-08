//
//  InfoContactViewController.m
//  CustomChat
//
//  Created by Wilson Mora on 12/5/16.
//  Copyright © 2016 WilsonApps. All rights reserved.
//

#import "InfoContactViewController.h"
#import "ContactTableViewCell.h"
#import "FirebaseHelper.h"
#import "InfoContactViewController.h"
#import "User.h"

@interface InfoContactViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)backAction:(id)sender;

@end

@implementation InfoContactViewController

@synthesize contactEmail;

NSString *cellReuseIdentifier;

NSMutableArray *dic;

UIActivityIndicatorView *indicator;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	FirebaseHelper *helper = [FirebaseHelper sharedInstance];
	
	helper.domainDelegate = self;
	
	cellReuseIdentifier = @"contactItem";
	
	/*dic = [NSMutableArray arrayWithArray:@[@{@"title":@"email",@"subtitle":@""},@{@"title":@"estado", @"subtitle":@""},@{@"title":@"disponibilidad",@"subtitle":@""}]];*/
	[self.tableView registerNib:[UINib nibWithNibName:@"ContactsCell" bundle:nil] forCellReuseIdentifier:cellReuseIdentifier];
	
	indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	[indicator setBackgroundColor:[UIColor grayColor]];
	[indicator setFrame:[self.view frame]];
	
	[User showLoader:indicator inView:self.view];
	
	[self getDataFromCloud];
	[self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender {
	
	[self dismissViewControllerAnimated:YES completion:nil];
	
}

-(void)getDataFromCloud{
	NSLog(@"path is %@",[self contactEmail]);
	
	[[FirebaseHelper sharedInstance] getExtraDataForUser:[self contactEmail]];

}

-(void)onExtraDataFound:(NSDictionary *)extraData forUserEmail:(NSString *)email{
	NSLog(@"data is %@",extraData);
	
	[User hideLoader:indicator];
	
	self.usernameLabel.text = [extraData objectForKey:@"username"];
	
	dic = [NSMutableArray arrayWithArray:
				 @[@{@"title":@"email",@"subtitle":email},@{@"title":@"estado", @"subtitle":[extraData objectForKey:@"status"]},@{@"title":@"disponibilidad",@"subtitle":[extraData objectForKey:@"availability"]}]];
	
	[self.tableView reloadData];
}

#pragma mark tableVeiw dataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return dic.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	ContactTableViewCell *cell = (ContactTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
	
	//[[[NSBundle mainBundle] loadNibNamed:@"ContactsCell" owner:self options:nil] objectAtIndex:0];
	
	NSLog(@"dic is %@",dic[indexPath.row]);
	
	/*if(cell==nil){
		NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ContactsCell" owner:self options:nil];
		cell = [array objectAtIndex:0];
		
		NSLog(@"cell loaded from xib");
	}*/
	
	cell.titleLabel.text = [[dic objectAtIndex:indexPath.row] objectForKey:@"title"];
	cell.subtitleLabel.text = [[dic objectAtIndex:indexPath.row] objectForKey:@"subtitle"];
	
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
