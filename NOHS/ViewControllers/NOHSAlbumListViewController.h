//
//  NOHSAlbumListViewController.h
//  NOHS
//
//  Created by Muhammad Nasir on 14/05/2016.
//  Copyright © 2016 Ali, Muhammad. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NOHSAlbumListViewControllerDelegate <NSObject>
- (void)didScrollToEndOfTheList;
@end

@interface NOHSAlbumListViewController : UIViewController
@property (nonatomic, retain) id <NOHSAlbumListViewControllerDelegate> delegate;
- (void)reloadWithAlbums:(NSArray*)albums;
@end
