//
//  NOHSServerCommunicationController.m
//  NOHS
//
//  Created by Muhammad Nasir on 14/05/2016.
//  Copyright © 2016 Ali, Muhammad. All rights reserved.
//

#import "NOHSServerCommunicationController.h"

@interface NOHSServerCommunicationController () <NSURLSessionDownloadDelegate>
@end

@implementation NOHSServerCommunicationController

@synthesize urlString = ivar_urlString;

- (void)dealloc {
    [super dealloc];
}

- (void)sendRequestToServer {
    NSURL *url = [NSURL URLWithString:ivar_urlString];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue: [NSOperationQueue mainQueue]];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url];
    [downloadTask resume];
}

/********************************************************************/
/********** NSURLSessionDownloadDelegate Implementation *************/
/********************************************************************/

#pragma mark NSSession Delegates Implementation

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    if ([self APIResponseSuccessCallback]) {
        NSData *data = [NSData dataWithContentsOfURL:location];
        self.APIResponseSuccessCallback(data);
    }
}

@end
