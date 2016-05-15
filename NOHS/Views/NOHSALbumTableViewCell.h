//
//  NOHSALbumTableViewCell.h
//  NOHS
//
//  Created by Muhammad Nasir on 14/05/2016.
//  Copyright © 2016 Ali, Muhammad. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NOHSAlbum;
@class NOHSTableCellMetaData;

@interface NOHSALbumTableViewCell : UITableViewCell
- (void)reloadCellWithAlbum:(NOHSAlbum*)album;
- (void)setupCellWithMetaData:(NOHSTableCellMetaData*)cellMetaData;
+ (CGFloat)heightWithAlbum:(NOHSAlbum*)album cellMetaData:(NOHSTableCellMetaData*)cellMetaData;
@end
