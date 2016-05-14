//
//  AppDelegate.m
//  NOHS
//
//  Created by Ali, Muhammad on 13/05/2016.
//  Copyright © 2016 Ali, Muhammad. All rights reserved.
//

#import "AppDelegate.h"
#import "NOHSRootViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NOHSRootViewController *rootViewController = [[NOHSRootViewController new] autorelease];
    UIWindow *mainWindow = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    [mainWindow setRootViewController:rootViewController];
    [mainWindow makeKeyAndVisible];
    self.window = mainWindow;
    return YES;
}

- (void)dealloc {
    if (self.window) {
        [self.window release];
    }
    [super dealloc];
}

@end
