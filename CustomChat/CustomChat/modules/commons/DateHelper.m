//
//  DateHelper.m
//  CustomChat
//
//  Created by Wilson Mora on 12/26/16.
//  Copyright © 2016 WilsonApps. All rights reserved.
//

#import "DateHelper.h"

@implementation DateHelper

+(NSString *)getDate{
	return nil;
}

+(NSString *)getExactDate{
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
	[formatter setDateFormat:@"MMddyyhhmmssmmss"];
	
	NSLog(@"date is %@",[formatter stringFromDate:[NSDate date]]);
	
	return [formatter stringFromDate:[NSDate date]];
}

+(NSString *)getHour{
	return nil;
}

@end
