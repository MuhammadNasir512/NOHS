//
//  NOHSALbumTableViewCell.m
//  NOHS
//
//  Created by Muhammad Nasir on 14/05/2016.
//  Copyright © 2016 Ali, Muhammad. All rights reserved.
//

#import "NOHSALbumTableViewCell.h"
#import "NOHSALbum.h"
#import "NOHSTableCellMetaData.h"
#import "NOHSUtilities.h"
#import "NSString+NOHSUtils.h"

static const CGFloat NOHSCellContentsPadding = 10.0f;
static const CGFloat NOHSCellContentsItmesHPadding = 15.0f;
static const CGFloat NOHSCellContentsItmesVPadding = 5.0f;
static const CGFloat NOHSThumbnailHeight = 60.0f;

@interface NOHSALbumTableViewCell ()
@property (nonatomic, retain) UILabel *labelForName;
@property (nonatomic, retain) UILabel *labelForYear;
@property (nonatomic, retain) UIImageView *imageViewThumbnail;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicatorForThumbnail;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicatorForReleaseYear;
@property (nonatomic, retain) NOHSTableCellMetaData *cellMetaData;
@property (nonatomic, retain) NOHSAlbum *album;
@end

@implementation NOHSALbumTableViewCell

- (void)dealloc {
    [_labelForName release];
    [_labelForYear release];
    [_imageViewThumbnail release];
    [_cellMetaData release];
    if (_activityIndicatorForThumbnail != nil) {
        [_activityIndicatorForThumbnail release];
    }
    [super dealloc];
}

+ (CGFloat)heightWithAlbum:(NOHSAlbum*)album cellMetaData:(NOHSTableCellMetaData*)cellMetaData {
    CGFloat maxNameLabelWidth = CGRectGetWidth([[cellMetaData tableView] bounds]) - 2.0f*NOHSCellContentsPadding - NOHSCellContentsItmesHPadding - NOHSThumbnailHeight;
    
    CGSize sizeMax = CGSizeMake(maxNameLabelWidth, INFINITY);
    CGFloat nameHeight = [album.name textSizeWithMaximumSize:sizeMax withFont:[cellMetaData fontForNameLabel]].height;
    CGFloat height = nameHeight + [[cellMetaData fontForYearLabel] lineHeight] + NOHSCellContentsItmesVPadding;
    height = (height >= NOHSThumbnailHeight)?height:NOHSThumbnailHeight;
    height += 2.0f*NOHSCellContentsPadding;
    return height;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    // its more convenient to check like "if (self) {}" but following is more performant
    if (nil != self) {
        
        // its more convenient to use [UILabel new]; but designated init is more recommended as follow
        UILabel *labelForName = [[UILabel alloc] initWithFrame:CGRectZero];
        [labelForName setNumberOfLines:0];
        [labelForName setLineBreakMode:NSLineBreakByWordWrapping];
        [[self contentView] addSubview:labelForName];
        _labelForName = labelForName;
        
        UILabel *labelForYear = [[UILabel alloc] initWithFrame:CGRectZero];
        [[self contentView] addSubview:labelForYear];
        _labelForYear = labelForYear;
        
        UIImageView *imageViewThumbnail = [[UIImageView alloc] initWithFrame:CGRectZero];
        [imageViewThumbnail setBackgroundColor:[UIColor blackColor]];
        [imageViewThumbnail setClipsToBounds:YES];
        [[imageViewThumbnail layer] setCornerRadius:10.0f];
        [[self contentView] addSubview:imageViewThumbnail];
        _imageViewThumbnail = imageViewThumbnail;
        
        UIActivityIndicatorView *activityIndicatorForThumbnail = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [activityIndicatorForThumbnail startAnimating];
        [[self contentView] addSubview:activityIndicatorForThumbnail];
        _activityIndicatorForThumbnail = activityIndicatorForThumbnail;
        
        UIActivityIndicatorView *activityIndicatorForReleaseYear = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityIndicatorForReleaseYear startAnimating];
        [[self contentView] addSubview:activityIndicatorForReleaseYear];
        _activityIndicatorForReleaseYear = activityIndicatorForReleaseYear;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat hh = NOHSThumbnailHeight;
    CGFloat ww = hh;
    CGFloat xx = NOHSCellContentsPadding;
    CGFloat yy = (CGRectGetHeight([self bounds]) - hh) * 0.5f;
    [_imageViewThumbnail setFrame:CGRectMake(xx, yy, ww, hh)];
    
    if (nil != _activityIndicatorForThumbnail) {
        [_activityIndicatorForThumbnail setCenter:[_imageViewThumbnail center]];
    }
    
    xx += ww + NOHSCellContentsItmesHPadding;
    yy =  NOHSCellContentsPadding;
    ww = CGRectGetWidth([self bounds]) - xx - NOHSCellContentsPadding;
    CGSize sizeMax = CGSizeMake(ww, INFINITY);
    hh = [[_labelForName text] textSizeWithMaximumSize:sizeMax withFont:[_cellMetaData fontForNameLabel]].height;
    [_labelForName setFrame:CGRectMake(xx, yy, ww, hh)];
    
    yy += hh + NOHSCellContentsItmesVPadding;
    hh = [[_cellMetaData fontForYearLabel] lineHeight];
    [_labelForYear setFrame:CGRectMake(xx, yy, ww, hh)];
    
    if (nil != _activityIndicatorForReleaseYear) {
        CGRect rect = [_labelForYear frame];
        rect.size.height = CGRectGetHeight([_activityIndicatorForReleaseYear bounds]);
        rect.size.width = rect.size.height;
        [_activityIndicatorForReleaseYear setFrame:rect];
    }
}

- (void)setupCellWithMetaData:(NOHSTableCellMetaData*)cellMetaData {
    _cellMetaData = cellMetaData;
    [_labelForName setFont:[cellMetaData fontForNameLabel]];
    [_labelForYear setFont:[cellMetaData fontForYearLabel]];
}

- (void)reloadCellWithAlbum:(NOHSAlbum*)album {
    [_labelForName setText:[album name]];
    [_labelForYear setText:@"Loading..."];
    [_imageViewThumbnail setImage:nil];
    
    [self setupAlbumReleaseYearWithAlbum:album];
    [self setupThumbnailImageWithAlbum:album];
}


#pragma mark Loading Album Details

- (void)setupAlbumReleaseYearWithAlbum:(NOHSAlbum*)album {
    __block typeof(self) blockSelf = self;
    __block typeof(album) blockAlbum = album;
    if (nil == [album releaseYear]) {
        [NOHSUtilities loadDataFromURL:[NSURL URLWithString:[blockAlbum detailsUrl]] callback:^(NSData *data) {
            NSDictionary *dataDictionary = [NOHSUtilities dictionaryRepresentationOfData:data];
            if (nil != dataDictionary) {
                NSString *releaseYear = [NOHSUtilities yearFromDateString:dataDictionary[@"release_date"]];
                [[blockSelf labelForYear] setText:releaseYear];
                [blockAlbum setReleaseYear:releaseYear];
            }
            [blockSelf removeReleaseYearActivityIndicator];
        }];
    }
    else {
        [[self labelForYear] setText:[album releaseYear]];
        [self removeReleaseYearActivityIndicator];
    }
}

- (void)removeReleaseYearActivityIndicator {
    [_activityIndicatorForReleaseYear stopAnimating];
    [_activityIndicatorForReleaseYear setHidden:YES];
}

#pragma mark Loading Thumbnail

- (void)setupThumbnailImageWithAlbum:(NOHSAlbum*)album {
    __block typeof(self) blockSelf = self;
    __block typeof(album) blockAlbum = album;
    if (nil == [album thumbnailImage]) {
        [NOHSUtilities loadDataFromURL:[NSURL URLWithString:[blockAlbum thumbnailUrl]] callback:^(NSData *data) {
            UIImage *image = [UIImage imageWithData:data];
            [[blockSelf imageViewThumbnail] setImage:image];
            [blockAlbum setThumbnailImage:image];
            [blockSelf removeThumbnailActivityIndicator];
        }];
    }
    else {
        [[self imageViewThumbnail] setImage:[album thumbnailImage]];
        [self removeThumbnailActivityIndicator];
    }
}

- (void)removeThumbnailActivityIndicator {
    [_activityIndicatorForThumbnail stopAnimating];
    [_activityIndicatorForThumbnail setHidden:YES];
}

- (void)showActivityIndicator:(UIActivityIndicatorView*)activityIndicatorView {
    [activityIndicatorView startAnimating];
    [activityIndicatorView setHidden:NO];
}

@end
