//
//  STTViewController.m
//  Storytime
//
//  Created by Jorge Cohen on 3/25/18.
//  Copyright © 2018 Jorge Cohen. All rights reserved.
//

#import "STTViewController.h"
#import "CXMLElement+Storytime.h"
#import "STTBoard.h"
#import "STTCSS.h"
#import "STTNavigationItem.h"
#import "STTScene.h"
#import "STTView.h"

@interface STTViewController ()

@end

@implementation STTViewController

- (instancetype)initWithXMLElement:(CXMLElement *)element board:(STTBoard *)board {
    self = [super init];
    if (self) {
        self.identifier = [element stringAttributeForName:@"id"];
        self.className = [element stringAttributeForName:@"customClass"];
        self.typeName = element.name;

        CXMLElement *viewElement = ([element elementForName:@"view"] ?: [element elementForName:@"tableView"]);
        self.rect = [[viewElement elementForName:@"rect"] rectValue];

        CXMLElement *navItemElement = [element elementForName:@"navigationItem"];

        if (navItemElement) {
            self.navigationItem = [[STTNavigationItem alloc] initWithXMLElement:navItemElement board:board];
        }

        self.rootView = [STTView viewWithXMLElement:viewElement board:board];
    }
    return self;
}

- (NSString *)htmlRepresentation {
    NSMutableString *html = [NSMutableString string];
    [html appendFormat:@"<div title='%@' id='%@' class='%@' style='%@'>", self.className, self.identifier, self.typeName, STTSizeToCSS(self.rect.size)];

    if (self.navigationItem) {
        [html appendString:[self.navigationItem htmlRepresentation]];
    }

    if (self.rootView) {
        [html appendString:[self.rootView htmlRepresentation]];
    }

    [html appendString:@"</div>"];

    return html;
}

@end
