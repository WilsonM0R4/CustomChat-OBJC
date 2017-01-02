//
//  MessageCell.h
//  CustomChat
//
//  Created by Wilson Mora on 12/29/16.
//  Copyright © 2016 WilsonApps. All rights reserved.
//

#define STYLE_CONTACT @"contactStyle"
#define STYLE_USER @"userStyle"

#import <UIKit/UIKit.h>


@interface MessageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *hourLabel;
@property BOOL isUser;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property NSString* cellStyle;

-(void)configureCell:(NSString *)cellStyle;

@end
