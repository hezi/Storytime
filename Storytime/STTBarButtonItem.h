//
//  STTBarButtonItem.h
//  Storytime
//
//  Created by Hezi Cohen on 3/26/18.
//  Copyright © 2018 Jorge Cohen. All rights reserved.
//

#import "STTElement.h"
#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    STTBarButtonPositionLeft,
    STTBarButtonPositionRight
} STTBarButtonPosition;

@interface STTBarButtonItem : NSObject <STTElement>
@property (nonatomic, assign) STTBarButtonPosition position;
@property (nonatomic) NSString *title;
@end
