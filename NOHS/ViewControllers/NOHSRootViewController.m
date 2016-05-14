//
//  NOHSRootViewController.m
//  NOHS
//
//  Created by Ali, Muhammad on 13/05/2016.
//  Copyright © 2016 Ali, Muhammad. All rights reserved.
//

#import "NOHSRootViewController.h"

@interface NOHSRootViewController ()
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@end

@implementation NOHSRootViewController

@synthesize tableView = ivar_tableView;

- (void)dealloc {
    if (nil != ivar_tableView) {
        [ivar_tableView release];
    }
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"View Did Load");
}

// https://api.spotify.com/v1/artists/36QJpDe2go2KgaRleHCDTp/albums?limit=50
@end
