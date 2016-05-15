//
//  NSString+NOHSUtils.m
//  NOHS
//
//  Created by Muhammad Nasir on 14/05/2016.
//  Copyright © 2016 Ali, Muhammad. All rights reserved.
//

#import "NSString+NOHSUtils.h"

@implementation NSString (NOHSUtils)

- (CGSize)textSizeWithMaximumSize:(CGSize)sizeMaximum withFont:(UIFont*)font {
    CGRect rect = [self boundingRectWithSize:sizeMaximum
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{NSFontAttributeName: font}
                                             context:nil];
    rect.size.width = ceil(rect.size.width);
    rect.size.height = ceil(rect.size.height);
    return rect.size;
}

@end
