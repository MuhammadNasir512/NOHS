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

@interface NOHSRootViewController () <NOHSDataControllerDelegate, NOHSAlbumListViewControllerDelegate>
@property (nonatomic, retain) NSArray *albums;
@property (nonatomic, retain) NOHSAlbumListViewController *albumsListViewController;
@property (nonatomic, retain) NOHSDataController *dataController;
@end

@implementation NOHSRootViewController

- (void)dealloc {
    if (nil != _albums) {
        [_albums release];
    }
    if (nil != _albumsListViewController) {
        [_albumsListViewController release];
    }
    if (nil != _dataController) {
        [_dataController release];
    }
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Albums"];
    [self addAlbumsListView];
    [self initAPIDataController];
    [self loadItemsInAlbumsList];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGRect frame = UIEdgeInsetsInsetRect([[self view] bounds], UIEdgeInsetsZero);
    [[_albumsListViewController view] setFrame:frame];
}

#pragma mark Creating List View

- (void)addAlbumsListView {
    NOHSAlbumListViewController *albumListViewController = [NOHSAlbumListViewController new];
    [albumListViewController setDelegate:self];
    [self addChildViewController:albumListViewController];
    [[self view] addSubview:[albumListViewController view]];
    [albumListViewController didMoveToParentViewController:self];
    _albumsListViewController = albumListViewController;
    [albumListViewController release];
}

- (void)didScrollToEndOfTheList {
    [self loadItemsInAlbumsList];
}

#pragma mark Data Loading

- (void)initAPIDataController {
    NOHSDataController *dataController = [NOHSDataController new];
    [dataController setDelegate:self];
    _dataController = dataController;
}
- (void)loadItemsInAlbumsList {
    [_dataController populateAlbumsArray];
}

- (void)dataControllerDidPrepareAlbums:(NSArray *)albums {
    [_albumsListViewController reloadWithAlbums:albums];
}

@end
