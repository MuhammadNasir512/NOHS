//
//  NOHSRootViewController.m
//  NOHS
//
//  Created by Ali, Muhammad on 13/05/2016.
//  Copyright © 2016 Ali, Muhammad. All rights reserved.
//

#import "NOHSRootViewController.h"
#import "NOHSDataController.h"
#import "NOHSAlbumListViewController.h"

@interface NOHSRootViewController () <NOHSDataControllerDelegate>
@property (nonatomic, retain) NSArray *albums;
@property (nonatomic, retain) NOHSAlbumListViewController *albumsViewController;
@end

@implementation NOHSRootViewController

- (void)dealloc {
    if (nil != _albums) {
        [_albums release];
    }
    if (nil != _albumsViewController) {
        [_albumsViewController release];
    }
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Albums"];
    [self addAlbumListView];
    [self prepareALbumList];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGRect frame = UIEdgeInsetsInsetRect([[self view] bounds], UIEdgeInsetsZero);
    [[_albumsViewController view] setFrame:frame];
}

#pragma mark Creating List View

- (void)addAlbumListView {
    NOHSAlbumListViewController *albumListViewController = [NOHSAlbumListViewController new];
    [self addChildViewController:albumListViewController];
    [[self view] addSubview:[albumListViewController view]];
    [albumListViewController didMoveToParentViewController:self];
    _albumsViewController = albumListViewController;
    [albumListViewController release];
}

#pragma mark Data Loading

- (void)prepareALbumList {
    NOHSDataController *dataController = [NOHSDataController new];
    [dataController setDelegate:self];
    [dataController createAlbumsArray];
}

- (void)dataControllerDidPrepareAlbums:(NSArray *)albums {
    [_albumsViewController reloadWithAlbums:albums];
}

@end
