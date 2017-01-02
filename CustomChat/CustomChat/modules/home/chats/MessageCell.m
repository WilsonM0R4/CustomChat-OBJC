//
//  MessageCell.m
//  CustomChat
//
//  Created by Wilson Mora on 12/29/16.
//  Copyright © 2016 WilsonApps. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
	
	self.containerView.layer.cornerRadius = (self.containerView.frame.size.height/3);
	
	}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
	
}

-(void)configureCell:(NSString *)cellStyle{
	
	if([cellStyle isEqualToString:STYLE_USER]){
	
		self.containerView.backgroundColor = [UIColor colorWithRed:0.00 green:0.50 blue:1.00 alpha:1.0];
		
	}else if([cellStyle isEqualToString:STYLE_CONTACT]){
		
		self.containerView.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0];
		
	}
}



@end
