//
//  STTBarButtonItem.m
//  Storytime
//
//  Created by Hezi Cohen on 3/26/18.
//  Copyright © 2018 Jorge Cohen. All rights reserved.
//

#import "STTBarButtonItem.h"
#import "CXMLElement+Storytime.h"

@implementation STTBarButtonItem
- (instancetype)initWithXMLElement:(CXMLElement *)element board:(STTBoard *)board {
    self = [super init];
    if (self) {
        self.title = [element stringAttributeForName:@"title"] ?: @"";
        if ([[element stringAttributeForName:@"key"] isEqualToString:@"leftBarButtonItem"]) {
            self.position = STTBarButtonPositionLeft;
        } else {
            self.position = STTBarButtonPositionRight;
        }
    }

    return self;
}

- (NSString *)htmlRepresentation {
    NSString *class;
    if (self.position == STTBarButtonPositionRight) {
        class = @"btn btn-link btn-nav pull-right";
    } else {
        class = @"btn btn-link btn-nav pull-left";
    }

    return [NSString stringWithFormat:@"<button class='%@'>%@</button>", class, self.title];
}

@end
