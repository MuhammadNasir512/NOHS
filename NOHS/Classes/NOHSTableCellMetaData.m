//
//  NOHSTableCellMetaData.m
//  NOHS
//
//  Created by Muhammad Nasir on 14/05/2016.
//  Copyright © 2016 Ali, Muhammad. All rights reserved.
//

#import "NOHSTableCellMetaData.h"

static const CGFloat NOHSFontSizeForNameText = 20.0f;
static const CGFloat NOHSFontSizeForYearText = 16.0f;

@implementation NOHSTableCellMetaData

- (void)dealloc {
    [_fontForNameLabel release];
    [_fontForYearLabel release];
    [_tableView release];
    [super dealloc];
}

- (UIFont *)fontForNameLabel {
    if (nil == _fontForNameLabel) {
        _fontForNameLabel = [UIFont boldSystemFontOfSize:NOHSFontSizeForNameText];
    }
    return _fontForNameLabel;
}

- (UIFont *)fontForYearLabel {
    if (nil == _fontForYearLabel) {
        _fontForYearLabel = [UIFont systemFontOfSize:NOHSFontSizeForYearText];
    }
    return _fontForYearLabel;
}

@end
