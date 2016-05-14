//
//  NOHSAlbumListViewController.m
//  NOHS
//
//  Created by Muhammad Nasir on 14/05/2016.
//  Copyright © 2016 Ali, Muhammad. All rights reserved.
//

#import "NOHSAlbumListViewController.h"
#import "NOHSALbumTableViewCell.h"
#import "NOHSAlbum.h"

static NSString *const NOHSTableViewCellIdentifier = @"NOHSCellID";

@interface NOHSAlbumListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) NSArray *albums;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@end

@implementation NOHSAlbumListViewController

- (void)dealloc {
    [_tableView release];
    [_albums release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_tableView registerClass:[NOHSALbumTableViewCell class] forCellReuseIdentifier:NOHSTableViewCellIdentifier];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGRect rect = [[self view] bounds];
    rect.size.height -= 5;
    [_tableView setFrame:rect];
}

- (void)reloadWithAlbums:(NSArray*)albums {
    _albums = nil;
    _albums = albums;
    [_tableView reloadData];
}

#pragma mark UITableViewDelegate, UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NOHSAlbum *album = (NOHSAlbum*)[_albums objectAtIndex:[indexPath row]];
    CGFloat height = [NOHSALbumTableViewCell heightWithAlbum:album];
    return height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_albums count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NOHSALbumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NOHSTableViewCellIdentifier];
    if (cell == nil) {
        cell = [[[NOHSALbumTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NOHSTableViewCellIdentifier] autorelease];
    }
    [[cell contentView] setBackgroundColor:([indexPath row] %2==0)?[UIColor colorWithWhite:0.95f alpha:1.0f]:[[tableView superview] backgroundColor]];
    NOHSAlbum *album = (NOHSAlbum*)[_albums objectAtIndex:[indexPath row]];
    [cell reloadCellWithAlbum:album];
    return cell;
}

@end
