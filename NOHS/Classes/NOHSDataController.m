//
//  NOHSDataController.m
//  NOHS
//
//  Created by Muhammad Nasir on 14/05/2016.
//  Copyright © 2016 Ali, Muhammad. All rights reserved.
//

#import "NOHSDataController.h"
#import "NOHSAlbum.h"
#import "NOHSUtilities.h"

@interface NOHSDataController ()
@property (nonatomic, retain) NSArray *albums;
@end

@implementation NOHSDataController

- (void)dealloc {
    self.delegate = nil;
    if (nil != _albums) {
        [_albums release];
    }
    [super dealloc];
}

- (void)createAlbumsArray {
    NSURL *url = [NSURL URLWithString:@"https://api.spotify.com/v1/artists/36QJpDe2go2KgaRleHCDTp/albums?limit=50"];
    
    __block typeof(self) blockSelf = self;
    [NOHSUtilities loadDataFromURL:url callback:^(NSData *data) {
        NSDictionary *dataDictionary = [NOHSUtilities dictionaryRepresentationOfData:data];
        if (dataDictionary != nil) {
            NSArray* dataArray = [dataDictionary objectForKey:@"items"];
            [blockSelf prepareAlbumArrayWithArray:dataArray];
        }
        dataDictionary = nil;
    }];
}

- (void)prepareAlbumArrayWithArray:(NSArray*)dataArray {
    NSMutableArray *albumsArray = [[NSMutableArray alloc] initWithCapacity:1];
    for (NSDictionary *dictionary in dataArray) {
        NOHSAlbum *album = [[NOHSAlbum alloc] initWithDictionary:dictionary];
        [albumsArray addObject:album];
        [album release];
    }
    if (nil != _albums) {
        [_albums release];
    }
    _albums = [[NSArray alloc] initWithArray:albumsArray];
    [albumsArray release];
    
    if ([self delegate]) {
        [[self delegate] dataControllerDidPrepareAlbums:_albums];
    }
}

@end
