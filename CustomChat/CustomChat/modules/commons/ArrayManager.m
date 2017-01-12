//
//  ArrayManager.m
//  CustomChat
//
//  Created by Wilson Mora on 1/4/17.
//  Copyright © 2017 WilsonApps. All rights reserved.
//

#import "ArrayManager.h"

@implementation ArrayManager

+(NSArray *)compareAndOrganizeDictionaryWithNumericKeys:(NSMutableDictionary *)dictionary{
	
	NSArray *keysArray = [dictionary allKeys];
	NSArray *tempArray;
	
	NSLog(@"keysArray: %@",keysArray);
	NSLog(@"received dictionary to sort: %@",dictionary);
	
	NSString *tempString = keysArray[0];
	
	NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:tempString ascending:YES];
	keysArray = [keysArray sortedArrayUsingDescriptors:@[sort]];
	
	NSLog(@"sorted keys are: %@",tempArray);
	
	/*for(int c=0; c<dictionary.count; c++){
		
		NSLog(@"position is %i",c);
		
		
		if(c<dictionary.count && c+1<dictionary.count){
			
			if(keysArray[c]<keysArray[c+1] && c<dictionary.count && c+1<dictionary.count ){
				NSLog(@"following position is %i",c+1);
				
				[tempArray addObject:[dictionary objectForKey:keysArray[c]]];
				[tempArray addObject:[dictionary objectForKey:keysArray[c+1]]];
				//[tempDictionary setObject:dictionary[keysArray[c]] forIndex:keysArray[c]];
				//[tempDictionary setObject:dictionary[keysArray[c+1]] forKey:keysArray[c+1]];
				
			}else if(keysArray[c]>keysArray[c+1] && c<dictionary.count && c+1<dictionary.count ){
				NSLog(@"following position is %i",c+1);
				
				[tempArray addObject:[dictionary objectForKey:keysArray[c+1]]];
				[tempArray addObject:[dictionary objectForKey:keysArray[c]]];
				//[tempDictionary setObject:dictionary[keysArray[c+1]] forKey:keysArray[c+1]];
				//[tempDictionary setObject:dictionary[keysArray[c]] forKey:keysArray[c]];
				
			}
			
		}else if(keysArray.count ==1){
		
			[tempArray addObject:[dictionary objectForKey:keysArray[0]]];
			
		}else{
			NSLog(@"condition have been broken");
		}
		
		
	}*/
	
	return tempArray;
}

@end
