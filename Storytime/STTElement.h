//
//  STTElement.h
//  Storytime
//
//  Created by Jorge Cohen on 3/25/18.
//  Copyright © 2018 Jorge Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class STTBoard;

@protocol STTElement <NSObject>
- (instancetype)initWithXMLElement:(id)element board:(STTBoard *)board;
- (NSString *)htmlRepresentation;
@end
