//
//  NOHSAlbum.h
//  NOHS
//
//  Created by Muhammad Nasir on 14/05/2016.
//  Copyright © 2016 Ali, Muhammad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NOHSAlbum : NSObject
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *releaseDate;
@property (nonatomic, retain) NSString *thumbnailUrl;
@property (nonatomic, retain) NSString *detailsUrl;
- (instancetype)initWithDictionary:(NSDictionary*)dictionary;
@end
