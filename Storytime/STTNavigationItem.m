//
//  STTNavigationItem.m
//  Storytime
//
//  Created by Jorge Cohen on 3/25/18.
//  Copyright © 2018 Jorge Cohen. All rights reserved.
//

#import "STTNavigationItem.h"
#import "STTBarButtonItem.h"
#import "CXMLElement+Storytime.h"

@implementation STTNavigationItem

- (instancetype)initWithXMLElement:(CXMLElement *)element board:(STTBoard *)board {
    self = [super init];
    if (self) {
        self.title = [element stringAttributeForName:@"title"] ?: @"";
        NSArray <CXMLElement*>* buttonElements = [element elementsForName:@"barButtonItem"];
        
        NSMutableArray *buttons = [NSMutableArray arrayWithCapacity:[buttonElements count]];
        for(CXMLElement *buttonElement in buttonElements) {
            if ([buttonElement isKindOfClass:[CXMLElement class]]) {
                [buttons addObject:[[STTBarButtonItem alloc] initWithXMLElement:buttonElement board:board]];
            }
        }
        
        self.buttons = buttons;
    }

    return self;
}

- (NSString *)htmlRepresentation {
    NSMutableString *html = [NSMutableString string];

    [html appendString:@"<header class='bar bar-nav'>"];

    for(STTBarButtonItem *button in self.buttons) {
        [html appendString:[button htmlRepresentation]];
    }

    [html appendFormat:@"<h1 class='title'>%@</h1>", self.title];
    [html appendString:@"</header>"];

    return html;
}

@end
