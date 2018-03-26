//
//  STTNavigationItem.m
//  Storytime
//
//  Created by Jorge Cohen on 3/25/18.
//  Copyright © 2018 Jorge Cohen. All rights reserved.
//

#import "STTNavigationItem.h"
#import "CXMLElement+Storytime.h"

@implementation STTNavigationItem

- (instancetype)initWithXMLElement:(CXMLElement *)element board:(STTBoard *)board {
    self = [super init];
    if (self) {
        self.title = [element stringAttributeForName:@"title"] ?: @"";
        //        NSArray <NSXMLElement*>* buttonElements = [element elementsForName:@"barButtonItem"];
        //
        //        for(NSXMLElement *buttonElement in buttonElements) {
        //            NSString *class = @"btn btn-link btn-nav pull-right";
        //
        //            if([[button attributeStringForName:@"key"] isEqualToString:@"leftBarButtonItem"] ) {
        //                class = @"btn btn-link btn-nav pull-left";
        //            }
        //
        //            [html appendFormat:@"<button class='%@'>%@</button>", class, self.title ?: self.image ? @"<span class='icon icon-stop'></span>": @""];
        //        }
    }

    return self;
}

- (NSString *)htmlRepresentation {
    NSMutableString *html = [NSMutableString string];

    [html appendString:@"<header class='bar bar-nav'>"];

    //    NSArray <NSXMLElement*>* buttons = [navigationItemElement elementsForName:@"barButtonItem"];
    //    for(NSXMLElement *button in buttons) {
    //        NSString *class = @"btn btn-link btn-nav pull-right";

    //        if([[button attributeStringForName:@"key"] isEqualToString:@"leftBarButtonItem"] ) {
    //            class = @"btn btn-link btn-nav pull-left";
    //        }

    //        [html appendFormat:@"<button class='%@'>%@</button>", class, self.title ?: self.image ? @"<span class='icon icon-stop'></span>": @""];
    //    }

    [html appendFormat:@"<h1 class='title'>%@</h1>", self.title];
    [html appendString:@"</header>"];

    return html;
}

@end
