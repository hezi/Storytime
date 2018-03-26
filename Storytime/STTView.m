//
//  STTView.m
//  Storytime
//
//  Created by Jorge Cohen on 3/25/18.
//  Copyright © 2018 Jorge Cohen. All rights reserved.
//

#import "STTView.h"
#import "CXMLElement+Storytime.h"
#import "STTCSS.h"
#import "STTTableView.h"

@interface STTPlaceholderView : STTView
@end

@implementation STTPlaceholderView
- (NSString *)htmlRepresentation {
    return [NSString stringWithFormat:
                         @"<div style='border: 1px solid lightgray; background-color:#A9C0DF80;  position: absolute; %@'>"
                         @"<div style='color: white; text-align:center; %@ line-height:%fpx'>%@</div>"
                         @"</div>",
                     STTRectToCSS(self.rect), STTSizeToCSS(self.rect.size), self.rect.size.height, self.typeName];
}
@end

@interface STTLabelView : STTView
@property (nonatomic) NSString *text;
@property (nonatomic) NSString *fontName;
@property (nonatomic, assign) CGFloat fontSize;
@end

@implementation STTLabelView
- (instancetype)initWithXMLElement:(CXMLElement *)element board:(STTBoard *)board {
    self = [super initWithXMLElement:element board:board];
    if (self) {
        self.text = [element stringAttributeForName:@"text"];
        self.fontSize = [[[element elementForName:@"fontDescription"] numberAttributeForName:@"pointSize"] floatValue];
    }

    return self;
}

- (NSString *)htmlRepresentation {
    return [NSString stringWithFormat:@"<div style='position: absolute; %@ font-size:%f; line-height: %fpx;'>%@</div>", STTRectToCSS(self.rect), self.fontSize, self.rect.size.height, self.text];
}
@end

@interface STTButtonView : STTView
@property (nonatomic) NSString *title;
@end

@implementation STTButtonView
- (instancetype)initWithXMLElement:(CXMLElement *)element board:(STTBoard *)board {
    self = [super initWithXMLElement:element board:board];
    if (self) {
        self.title = [[element elementForName:@"state"] stringAttributeForName:@"title"];
    }

    return self;
}

- (NSString *)htmlRepresentation {
    return [NSString stringWithFormat:@"<button class='btn-link' style='position: absolute; %@'>%@</button>", STTRectToCSS(self.rect), self.title];
}
@end

@interface STTStepperView : STTView
@end

@implementation STTStepperView
- (NSString *)htmlRepresentation {
    return [NSString stringWithFormat:@"<div class='segmented-control' style='position: absolute; %@'>"
                                      @"<a class='control-item'>-</a>"
                                      @"<a class='control-item'>+</a>"
                                      @"</div>",
                     STTRectToCSS(self.rect)];
}
@end

@interface STTSegmentedControlView : STTView
@property (nonatomic) NSArray *segments;
@property (nonatomic) NSUInteger selectedSegmentIndex;
@end

@implementation STTSegmentedControlView
- (instancetype)initWithXMLElement:(CXMLElement *)element board:(STTBoard *)board {
    self = [super initWithXMLElement:element board:board];
    if (self) {
        self.selectedSegmentIndex = [[element numberAttributeForName:@"selectedSegmentIndex"] integerValue];

        NSMutableArray *segments = [NSMutableArray arrayWithCapacity:[element elementForName:@"segments"].children.count];

        for (CXMLElement *segmentElement in [element elementForName:@"segments"].children) {
            if ([segmentElement isKindOfClass:[CXMLElement class]]) {
                [segments addObject:[segmentElement stringAttributeForName:@"title"]];
            }
        }

        self.segments = segments;
    }

    return self;
}

- (NSString *)htmlRepresentation {
    NSMutableString *html = [NSMutableString string];
    [html appendFormat:@"<div class='segmented-control' style='position: absolute; %@'>", STTRectToCSS(self.rect)];

    for (NSString *segment in self.segments) {
        [html appendFormat:@"<a class='control-item %@'>%@</a>", [self.segments indexOfObject:segment] == self.selectedSegmentIndex ? @"active" : @"", segment];
    }
    [html appendString:@"</div>"];

    return html;
}
@end

@interface STTSwitchView : STTView
@end

@implementation STTSwitchView
- (NSString *)htmlRepresentation {
    return [NSString stringWithFormat:@"<div style='position: absolute; %@'>"
                                      @"<div class='toggle active'>"
                                      @"    <div class='toggle-handle'></div>"
                                      @"</div>"
                                      @"</div>",
                     STTRectToCSS(self.rect)];
}
@end

@implementation STTView
+ (STTView *)viewWithXMLElement:(CXMLElement *)element board:(STTBoard *)board {
    if ([element.name isEqualToString:@"view"] || [element.name isEqualToString:@"tableViewCellContentView"]) {
        return [[STTView alloc] initWithXMLElement:element board:board];
    } else if ([element.name isEqualToString:@"tableView"]) {
        return [[STTTableView alloc] initWithXMLElement:element board:board];
    } else if ([element.name isEqualToString:@"label"]) {
        return [[STTLabelView alloc] initWithXMLElement:element board:board];
    } else if ([element.name isEqualToString:@"button"]) {
        return [[STTButtonView alloc] initWithXMLElement:element board:board];
    } else if ([element.name isEqualToString:@"imageView1"]) {
        return [[STTPlaceholderView alloc] initWithXMLElement:element board:board];
    } else if ([element.name isEqualToString:@"stepper"]) {
        return [[STTStepperView alloc] initWithXMLElement:element board:board];
    } else if ([element.name isEqualToString:@"segmentedControl"]) {
        return [[STTSegmentedControlView alloc] initWithXMLElement:element board:board];
    } else if ([element.name isEqualToString:@"switch"]) {
        return [[STTSwitchView alloc] initWithXMLElement:element board:board];
    }

    return [[STTPlaceholderView alloc] initWithXMLElement:element board:board];
}

- (instancetype)initWithXMLElement:(CXMLElement *)element board:(STTBoard *)board {
    self = [super init];
    if (self) {
        self.rect = [[element elementForName:@"rect"] rectValue];
        self.typeName = element.name;

        NSMutableArray *subviews = [NSMutableArray arrayWithCapacity:[[[element elementForName:@"subviews"] children] count]];
        for (CXMLElement *subviewElement in [[element elementForName:@"subviews"] children]) {
            if ([subviewElement isKindOfClass:[CXMLElement class]]) {
                [subviews addObject:[STTView viewWithXMLElement:subviewElement board:board]];
            }
        }

        self.subviews = subviews;
    }

    return self;
}

- (NSString *)htmlRepresentation {
    NSMutableString *html = [NSMutableString string];
    [html appendFormat:@"<div style='position: absolute; %@'>", STTRectToCSS(self.rect)];

    for (STTView *view in self.subviews) {
        [html appendString:[view htmlRepresentation]];
    }

    [html appendString:@"</div>"];

    return html;
}
@end
