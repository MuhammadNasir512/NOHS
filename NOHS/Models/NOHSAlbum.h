//
//  NOHSAlbum.h
//  NOHS
//
//  Created by Muhammad Nasir on 14/05/2016.
//  Copyright © 2016 Ali, Muhammad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NOHSAlbum : NSObject
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *releaseYear;
@property (nonatomic, retain) NSString *thumbnailUrl;
@property (nonatomic, retain) NSString *detailsUrl;
@property (nonatomic, retain) UIImage *thumbnailImage;
- (instancetype)initWithDictionary:(NSDictionary*)dictionary;
@end
