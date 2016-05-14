//
//  NOHSServerCommunicationController.h
//  NOHS
//
//  Created by Muhammad Nasir on 14/05/2016.
//  Copyright © 2016 Ali, Muhammad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NOHSServerCommunicationController : NSObject

@property(nonatomic,retain) NSString *urlString;
@property (nonatomic, copy) void (^APIResponseSuccessCallback)(NSData *data);

- (void)sendRequestToServer;
@end
