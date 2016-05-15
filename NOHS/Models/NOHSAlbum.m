//
//  NOHSAlbum.m
//  NOHS
//
//  Created by Muhammad Nasir on 14/05/2016.
//  Copyright © 2016 Ali, Muhammad. All rights reserved.
//

#import "NOHSAlbum.h"

@implementation NOHSAlbum

- (void)dealloc {
    [_name release];
    [_detailsUrl release];
    [_thumbnailUrl release];
    [super dealloc];
}

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    self = [super init];
    if (nil != self) {
        _name = [[self nameStringWithDictionary:dictionary] retain];
        _detailsUrl = [dictionary[@"href"] retain];
        _thumbnailUrl = [[self thumbnailUrlWithDictionary:dictionary] retain];
    }
    return self;
}

- (NSString*)nameStringWithDictionary:(NSDictionary*)dictionary {
    NSString *name = [dictionary[@"name"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return name;
}

- (NSString*)thumbnailUrlWithDictionary:(NSDictionary*)dictionary {
    NSDictionary *imageItemSelected = nil;
    NSInteger index = 0;
    NSInteger maxHeight = 0;
    
    for (NSDictionary *imageItem in dictionary[@"images"]) {
        if (index == 0) {
            maxHeight = [imageItem[@"height"] integerValue];
        }
        else {
            NSInteger imageHeight = [imageItem[@"height"] integerValue];
            if (imageHeight < maxHeight) {
                maxHeight = imageHeight;
                imageItemSelected = imageItem;
            }
        }
        index++;
    }
    
    if (imageItemSelected) {
        return imageItemSelected[@"url"];
    }
    return nil;
}

@end
