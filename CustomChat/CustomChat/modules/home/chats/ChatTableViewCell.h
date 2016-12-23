//
//  ChatTableViewCell.h
//  CustomChat
//
//  Created by Wilson Mora on 12/23/16.
//  Copyright © 2016 WilsonApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subtitle;
@property (weak, nonatomic) IBOutlet UIImageView *contactImageView;

@end
