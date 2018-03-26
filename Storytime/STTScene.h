//
//  STTScene.h
//  Storytime
//
//  Created by Jorge Cohen on 3/25/18.
//  Copyright © 2018 Jorge Cohen. All rights reserved.
//

#import "STTElement.h"
#import <Foundation/Foundation.h>

@class STTBoard;

@interface STTScene : NSObject <STTElement>
@property (nonatomic, assign) CGPoint origin;
@end
