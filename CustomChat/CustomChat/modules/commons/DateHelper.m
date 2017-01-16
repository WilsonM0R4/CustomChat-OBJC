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
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yy/MM/dd"];
	
	return [formatter stringFromDate:[NSDate date]];
}

+(NSString *)getExactDate{
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
	[formatter setDateFormat:@"yyMMddhhmmssmmss"];
	
	NSLog(@"date is %@",[formatter stringFromDate:[NSDate date]]);
	
	return [formatter stringFromDate:[NSDate date]];
}

+(NSString *)getHour{
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"hh:mm a"];
	
	NSString *hour = [formatter stringFromDate:[NSDate date]];
	
	hour = [hour stringByReplacingOccurrencesOfString:@"p.m." withString:@"pm"];
	hour = [hour stringByReplacingOccurrencesOfString:@"a.m." withString:@"am"];
	
	return hour;
}

@end
