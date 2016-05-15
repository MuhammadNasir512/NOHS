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
@property (nonatomic, retain) NSString *apiURLString;
@end

@implementation NOHSDataController

- (void)dealloc {
    self.delegate = nil;
    if (nil != _albums) {
        [_albums release];
    }
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (nil != self) {
        _apiURLString = @"https://api.spotify.com/v1/artists/36QJpDe2go2KgaRleHCDTp/albums?limit=10";
    }
    return self;
}

- (void)populateAlbumsArray {
    if ([_apiURLString isEqual:[NSNull null]] || _apiURLString == nil || [_apiURLString length] == 0) {
        return;
    }
    NSURL *url = [NSURL URLWithString:_apiURLString];
    
    __block typeof(self) blockSelf = self;
    [NOHSUtilities loadDataFromURL:url callback:^(NSData *data) {
        NSDictionary *dataDictionary = [NOHSUtilities dictionaryRepresentationOfData:data];
        if (dataDictionary != nil) {
            blockSelf.apiURLString = [dataDictionary objectForKey:@"next"];
            NSArray* dataArray = [dataDictionary objectForKey:@"items"];
            [blockSelf prepareAlbumArrayWithArray:dataArray];
        }
        dataDictionary = nil;
    }];
}

- (void)prepareAlbumArrayWithArray:(NSArray*)dataArray {
    NSMutableArray *albumsArray = [[NSMutableArray alloc] initWithCapacity:1];
    if (nil != _albums) {
        [albumsArray addObjectsFromArray:_albums];
        [_albums release];
    }
    for (NSDictionary *dictionary in dataArray) {
        NOHSAlbum *album = [[NOHSAlbum alloc] initWithDictionary:dictionary];
        [albumsArray addObject:album];
        [album release];
    }
    _albums = [[NSArray alloc] initWithArray:albumsArray];
    [albumsArray release];
    
    if ([self delegate]) {
        [[self delegate] dataControllerDidPrepareAlbums:_albums];
    }
}

@end
