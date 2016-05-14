//
//  NOHSDataController.m
//  NOHS
//
//  Created by Muhammad Nasir on 14/05/2016.
//  Copyright © 2016 Ali, Muhammad. All rights reserved.
//

#import "NOHSDataController.h"
#import "NOHSServerCommunicationController.h"
#import "NOHSAlbum.h"

@interface NOHSDataController () <NOHSServerCommunicationControllerDelegate>
@property (nonatomic, retain) NSArray *albums;
@end

@implementation NOHSDataController

- (void)dealloc {
    self.delegate = nil;
    [super dealloc];
}

- (void)createAlbumsArray {
    NOHSServerCommunicationController *apiController = [NOHSServerCommunicationController new];
    [apiController setDelegate:self];
    [apiController setUrlString:@"https://api.spotify.com/v1/artists/36QJpDe2go2KgaRleHCDTp/albums?limit=50"];
    [apiController sendRequestToServer];
}

- (void)serverCommunicationControllerDidLoadData:(NSData *)data {
    
    if (data != nil) {
        NSError *error;
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if (dataDictionary != nil) {
            NSArray* dataArray = [dataDictionary objectForKey:@"items"];
            [self prepareAlbumArrayWithArray:dataArray];
        }
        dataDictionary = nil;
    }
}

- (void)prepareAlbumArrayWithArray:(NSArray*)dataArray {
    NSMutableArray *albumsArray = [[NSMutableArray alloc] initWithCapacity:1];
    for (NSDictionary *dictionary in dataArray) {
        NOHSAlbum *album = [[NOHSAlbum alloc] initWithDictionary:dictionary];
        [albumsArray addObject:album];
        [album release];
    }
    if (_albums) {
        [_albums release];
    }
    _albums = [[NSArray alloc] initWithArray:albumsArray];
    [albumsArray release];
    
    if ([self delegate]) {
        [[self delegate] dataControllerDidPrepareAlbums:_albums];
    }
}

@end
