//
//  NOHSRootViewController.m
//  NOHS
//
//  Created by Ali, Muhammad on 13/05/2016.
//  Copyright © 2016 Ali, Muhammad. All rights reserved.
//

#import "NOHSRootViewController.h"
#import "NOHSServerCommunicationController.h"

typedef void (^APIResponseSuccessCallback)(NSData *responseData);

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
    [self makeAPICallToLoadData];
}

- (void)makeAPICallToLoadData {
    NOHSServerCommunicationController *apiController = [NOHSServerCommunicationController new];
    [apiController setUrlString:@"https://api.spotify.com/v1/artists/36QJpDe2go2KgaRleHCDTp/albums?limit=50"];
    [apiController setAPIResponseSuccessCallback:^(NSData *data) {
        if (data != nil) {
            NSError* error;
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:kNilOptions
                                                                   error:&error];
            
            NSArray* latestLoans = [json objectForKey:@"items"];
            
            NSLog(@"items: %@", latestLoans);
        }
        
    }];
    [apiController sendRequestToServer];
}

@end
