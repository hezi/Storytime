//
//  STTBoard.h
//  Storytime
//
//  Created by Jorge Cohen on 3/25/18.
//  Copyright © 2018 Jorge Cohen. All rights reserved.
//

#import "STTElement.h"
#import <Foundation/Foundation.h>

@interface STTBoard : NSObject
- (instancetype)initWithURL:(NSURL *)url;
- (instancetype)initWithXMLString:(NSString *)xmlString;
- (NSString *)htmlRepresentation;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, readonly) NSString *initialViewController;
@property (nonatomic, readonly) NSArray *scenes;
@end
