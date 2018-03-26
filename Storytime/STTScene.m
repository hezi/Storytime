//
//  STTScene.m
//  Storytime
//
//  Created by Jorge Cohen on 3/25/18.
//  Copyright © 2018 Jorge Cohen. All rights reserved.
//

#import "STTScene.h"
#import "CXMLElement+Storytime.h"
#import "STTBoard.h"
#import "STTCSS.h"
#import "STTViewController.h"

@interface STTScene ()
@property (nonatomic) NSMutableArray *viewControllers;
@end

@implementation STTScene
- (instancetype)initWithXMLElement:(CXMLElement *)element board:(STTBoard *)board {
    self = [super init];
    if (self) {
        CGPoint point = [[element elementForName:@"point"] pointValue];
        self.origin = point;

        // Storyboards can sometimes contain scenes with minus coordinates (e.g. {-165, -234})
        // It's not an issue for IB, since it always centers the canvas. In our HTML/CSS combo
        // scenes were being placed outside of the viewport, so by keeping track of the min. origin point
        // we can later apply css to translate the whole thing so it's properly shown.
        board.origin = CGPointMake(MIN(point.x, board.origin.x), MIN(point.y, board.origin.y));

        NSError *error;
        NSArray *viewControllerElements = [element nodesForXPath:@"objects/viewController | objects/tableViewController | objects/navigationController" error:&error];
        NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:viewControllerElements.count];

        for (CXMLElement *vc in viewControllerElements) {
            [viewControllers addObject:[[STTViewController alloc] initWithXMLElement:vc board:board]];
        }

        self.viewControllers = viewControllers;
    }
    return self;
}

- (NSString *)htmlRepresentation {
    NSMutableString *html = [NSMutableString string];
    [html appendFormat:@"<div style='position:absolute; %@'>", STTPointToCSS(self.origin)];

    for (STTViewController *vc in self.viewControllers) {
        [html appendString:[vc htmlRepresentation]];
    }

    [html appendString:@"</div>"];

    return html;
}

@end
