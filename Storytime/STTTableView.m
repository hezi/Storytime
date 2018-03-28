//
//  STTTableView.m
//  Storytime
//
//  Created by Jorge Cohen on 3/25/18.
//  Copyright © 2018 Jorge Cohen. All rights reserved.
//

#import "STTTableView.h"
#import "CXMLElement+Storytime.h"
#import "STTCSS.h"
#import "STTView.h"

@interface STTTableViewCell : NSObject <STTElement>
@property (nonatomic) STTView *contentView;
@property (nonatomic, assign) CGRect rect;
@end

@implementation STTTableViewCell
- (instancetype)initWithXMLElement:(CXMLElement *)element board:(STTBoard *)board {
    self = [super init];
    if (self) {
        self.rect = [[element elementForName:@"rect"] rectValue];
        self.contentView = [STTView viewWithXMLElement:[element elementForName:@"tableViewCellContentView"] board:board];
    }

    return self;
}

- (NSString *)htmlRepresentation {
    NSMutableString *html = [NSMutableString string];

    [html appendFormat:@"<li class='table-view-cell' style='%@'>", STTSizeToCSS(self.rect.size)];
    [html appendString:[self.contentView htmlRepresentation]];
    [html appendString:@"</li>"];

    return html;
}
@end

@interface STTTableViewSection : NSObject <STTElement>
@property (nonatomic) NSString *headerTitle;
@property (nonatomic) NSString *footerTitle;
@property (nonatomic) NSMutableArray *cells;
@end

@implementation STTTableViewSection
- (instancetype)initWithXMLElement:(CXMLElement *)element board:(STTBoard *)board {
    self = [super init];
    if (self) {
        self.headerTitle = [element stringAttributeForName:@"headerTitle"];
        self.footerTitle = [element stringAttributeForName:@"footerTitle"];

        NSMutableArray *cells = [NSMutableArray arrayWithCapacity:[[[element elementForName:@"cells"] children] count]];
        for (CXMLElement *cellElement in [[element elementForName:@"cells"] children]) {
            if ([cellElement isKindOfClass:[CXMLElement class]]) {
                [cells addObject:[[STTTableViewCell alloc] initWithXMLElement:cellElement board:board]];
            }
        }

        self.cells = cells;
    }

    return self;
}

- (NSString *)htmlRepresentation {
    NSMutableString *html = [NSMutableString string];
    if (self.headerTitle) {
        [html appendFormat:@"<li class='table-view-divider table-view-section-header'>%@</li>", self.headerTitle];
    }

    for (STTTableViewCell *cell in self.cells) {
        [html appendString:[cell htmlRepresentation]];
    }

    if (self.footerTitle) {
        [html appendFormat:@"<li class='table-view-divider table-view-section-footer'>%@</li>", self.footerTitle];
    }

    return html;
}
@end

@implementation STTTableView
- (instancetype)initWithXMLElement:(CXMLElement *)element board:(STTBoard *)board {
    self = [super initWithXMLElement:element board:board];
    if (self) {
        NSArray *sectionElements = [[element elementForName:@"sections"] elementsForName:@"tableViewSection"];
        NSMutableArray *sections = [NSMutableArray arrayWithCapacity:[sectionElements count]];
        for (CXMLElement *sectionElement in sectionElements) {
            [sections addObject:[[STTTableViewSection alloc] initWithXMLElement:sectionElement board:board]];
        }

        self.sections = sections;
    }

    return self;
}

- (NSString *)htmlRepresentation {
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<ul class='table-view'>"];

    for (STTTableViewSection *section in self.sections) {
        [html appendString:[section htmlRepresentation]];
    }

    [html appendString:@"</ul>"];
    return html;
}
@end
