//
//  User.m
//  CustomChat
//
//  Created by Wilson Mora on 11/3/16.
//  Copyright © 2016 WilsonApps. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize username, userEmail, userAvailability, status, profileImage;	 

-(id)init{
	
	id theSelf = [super init];
	
	return theSelf;
}

+(NSString *)formatEmail:(NSString *)email{
	return [email stringByReplacingOccurrencesOfString:@"." withString:@"_"];
}

+(void)showLoader:(UIActivityIndicatorView *)indicatorView inView:(UIView *)parentView{
	[parentView addSubview:indicatorView];
	[indicatorView startAnimating];
}

+(void)hideLoader:(UIActivityIndicatorView *)indicatorView{
	[indicatorView stopAnimating];
	[indicatorView removeFromSuperview];
}

@end
