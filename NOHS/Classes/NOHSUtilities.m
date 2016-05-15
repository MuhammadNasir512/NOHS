//
//  NOHSUtilities.m
//  NOHS
//
//  Created by Muhammad Nasir on 15/05/2016.
//  Copyright © 2016 Ali, Muhammad. All rights reserved.
//

#import "NOHSUtilities.h"

static NSString *const NOHSReleaseYearUnknownLitteral = @"Release Year Unknown";

@implementation NOHSUtilities

+ (void)loadDataFromURL:(NSURL*)imageUrl callback:(void (^)(NSData *data))callback {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0ul);
    dispatch_async(queue, ^{
        NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
        dispatch_async(dispatch_get_main_queue(), ^{
            callback(imageData);
        });
    });
}

+ (NSDictionary*)dictionaryRepresentationOfData:(NSData*)data {
    if (data != nil) {
        NSError *error;
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        return dataDictionary;
    }
    return nil;
}

+ (NSString*)yearFromDateString:(NSString*)dateString {
    if ([dateString length] == 0) {
        return NOHSReleaseYearUnknownLitteral;
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-mm-dd"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    [dateFormatter release];
    
    if (nil == date) {
        return NOHSReleaseYearUnknownLitteral;
    }
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:date];
    return [NSString stringWithFormat:@"%ld", (long)[components year]];
}

@end
