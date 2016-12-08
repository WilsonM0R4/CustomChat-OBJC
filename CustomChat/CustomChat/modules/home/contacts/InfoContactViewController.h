//
//  InfoContactViewController.h
//  CustomChat
//
//  Created by Wilson Mora on 12/5/16.
//  Copyright © 2016 WilsonApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirebaseHelper.h"

@interface InfoContactViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,DomainProtocol>

@property (weak,nonatomic) NSString *contactEmail;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

//+(void)onExtraDataFound:(NSDictionary *)extraData forUserEmail:(NSString *)email;

@end
