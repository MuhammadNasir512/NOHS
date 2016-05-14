//
//  NOHSALbumTableViewCell.m
//  NOHS
//
//  Created by Muhammad Nasir on 14/05/2016.
//  Copyright © 2016 Ali, Muhammad. All rights reserved.
//

#import "NOHSALbumTableViewCell.h"
#import "NOHSALbum.h"

//static const CGFloat NOHSCellContentsPadding = 20.0f;
//static const CGFloat NOHSCellContentsItmesPadding = 5.0f;

@implementation NOHSALbumTableViewCell

+ (CGFloat)heightWithAlbum:(NOHSAlbum*)album {
    return 60.0f;
}

- (void)dealloc {
    [super dealloc];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)reloadCellWithAlbum:(NOHSAlbum*)album {
    [[self textLabel] setText:[album name]];
}

@end
