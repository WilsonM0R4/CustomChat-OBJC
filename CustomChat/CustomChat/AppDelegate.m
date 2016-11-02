//
//  AppDelegate.m
//  CustomChat
//
//  Created by Wilson Mora on 10/18/16.
//  Copyright © 2016 WilsonApps. All rights reserved.
//

#import "AppDelegate.h"
#import <Firebase/Firebase.h>
#import "FirebaseHelper.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// Override point for customization after application launch.
	
	
	//configure firebase
	[FIRApp configure];
	[[FirebaseHelper sharedInstance] launchAuthListener];
	
	/**
	 * used for set programmatically a root viewController
	 **/
	
	//get reference from storyboard
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	
	//instantiate the first view controller
	UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"viewContorller"];
	
	//instantiate the root view controller(navigation controller)
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
	
	//set a title for the view controller
	[viewController setTitle:@"CustomChat"];
	
	//get reference for the application window
	_window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	//add the root view controller to the app window
	[_window setRootViewController:navController];
	
	//make visible the window
	[_window makeKeyAndVisible];
	
	
	return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
