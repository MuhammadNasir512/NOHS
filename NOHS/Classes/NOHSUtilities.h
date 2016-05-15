//
//  NOHSUtilities.h
//  NOHS
//
//  Created by Muhammad Nasir on 15/05/2016.
//  Copyright © 2016 Ali, Muhammad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NOHSUtilities : NSObject
+ (void)loadDataFromURL:(NSURL*)imageUrl callback:(void (^)(NSData *data))callback;
+ (NSDictionary*)dictionaryRepresentationOfData:(NSData*)data;
+ (NSString*)yearFromDateString:(NSString*)dateString;
@end
