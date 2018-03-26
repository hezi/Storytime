//
//  STTCoreGraphicsCSS.m
//  Storytime
//
//  Created by Jorge Cohen on 3/25/18.
//  Copyright © 2018 Jorge Cohen. All rights reserved.
//

#import "STTCSS.h"

NSString *STTPointToCSS(CGPoint point) {
    return [NSString stringWithFormat:@"top:%fpx; left:%fpx;", point.y, point.x];
}

NSString *STTSizeToCSS(CGSize size) {
    return [NSString stringWithFormat:@"width:%fpx; height:%fpx;", size.width, size.height];
}

NSString *STTRectToCSS(CGRect rect) {
    return [NSString stringWithFormat:@"%@ %@", STTPointToCSS(rect.origin), STTSizeToCSS(rect.size)];
}
