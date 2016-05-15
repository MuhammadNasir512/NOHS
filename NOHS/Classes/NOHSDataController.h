//
//  NOHSDataController.h
//  NOHS
//
//  Created by Muhammad Nasir on 14/05/2016.
//  Copyright © 2016 Ali, Muhammad. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NOHSDataControllerDelegate <NSObject>
- (void)dataControllerDidPrepareAlbums:(NSArray*)albums;
@end

@interface NOHSDataController : NSObject
@property(nonatomic, assign) id <NOHSDataControllerDelegate> delegate;
- (void)populateAlbumsArray;
@end
