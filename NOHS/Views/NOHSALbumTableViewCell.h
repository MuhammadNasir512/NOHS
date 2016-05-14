//
//  NOHSALbumTableViewCell.h
//  NOHS
//
//  Created by Muhammad Nasir on 14/05/2016.
//  Copyright © 2016 Ali, Muhammad. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NOHSAlbum;
@interface NOHSALbumTableViewCell : UITableViewCell
- (void)reloadCellWithAlbum:(NOHSAlbum*)album;
+ (CGFloat)heightWithAlbum:(NOHSAlbum*)album;
@end
