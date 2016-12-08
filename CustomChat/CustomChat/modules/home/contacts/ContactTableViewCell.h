//
//  ContactTableViewCell.h
//  CustomChat
//
//  Created by Wilson Mora on 12/7/16.
//  Copyright © 2016 WilsonApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

@end
