//
//  STTBoard.m
//  Storytime
//
//  Created by Jorge Cohen on 3/25/18.
//  Copyright © 2018 Jorge Cohen. All rights reserved.
//

#import "STTBoard.h"
#import "CXMLDocument.h"
#import "CXMLElement+Storytime.h"
#import "CXMLElement.h"
#import "STTScene.h"

@interface STTBoard ()
@property (nonatomic) NSString *initialViewController;
@property (nonatomic) NSMutableArray *scenes;
@end

@implementation STTBoard
@synthesize scenes;

- (instancetype)initWithURL:(NSURL *)url {
    self = [super init];
    if (self) {
        self.origin = (CGPoint){ CGFLOAT_MAX, CGFLOAT_MAX };

        NSError *error;
        CXMLDocument *storyboardXML = [[CXMLDocument alloc] initWithContentsOfURL:url options:0 error:&error];

        [self parseWithDocument:storyboardXML];
    }
    return self;
}

- (instancetype)initWithXMLString:(NSString *)xmlString {
    self = [super init];
    if (self) {
        self.origin = (CGPoint){ CGFLOAT_MAX, CGFLOAT_MAX };

        NSError *error;
        CXMLDocument *storyboardXML = [[CXMLDocument alloc] initWithXMLString:xmlString options:0 error:&error];

        [self parseWithDocument:storyboardXML];
    }
    return self;
}

- (void)parseWithDocument:(CXMLDocument *)document {
    NSError *error;
    CXMLElement *rootElement = [document rootElement];
    self.initialViewController = [rootElement stringAttributeForName:@"initialViewController"];

    NSArray *sceneElements = [document nodesForXPath:@".//scenes/scene" error:&error];
    NSMutableArray *scenes = [NSMutableArray arrayWithCapacity:sceneElements.count];

    for (CXMLElement *scene in sceneElements) {
        [scenes addObject:[[STTScene alloc] initWithXMLElement:scene board:self]];
    }

    self.scenes = scenes;
}

- (NSString *)htmlRepresentation {
    NSString *bodyStyle = [NSString stringWithFormat:@"position:absolute; top:%f; left:%f", self.origin.y * -1, self.origin.x * -1];

    NSString *template = [NSString stringWithContentsOfURL:[[NSBundle bundleForClass:self.class] URLForResource:@"template" withExtension:@"html"]
                                                  encoding:NSUTF8StringEncoding
                                                     error:nil];

    NSString *css1 = [NSString stringWithContentsOfURL:[[NSBundle bundleForClass:self.class] URLForResource:@"ratchet" withExtension:@"css"]
                                              encoding:NSUTF8StringEncoding
                                                 error:nil];

    NSString *css2 = [NSString stringWithContentsOfURL:[[NSBundle bundleForClass:self.class] URLForResource:@"ratchet-theme-ios.min" withExtension:@"css"]
                                              encoding:NSUTF8StringEncoding
                                                 error:nil];

    NSString *cssImports = [NSString stringWithFormat:@"%@ \n \n %@", css1, css2];

    NSMutableString *scenesHTML = [NSMutableString string];
    for (STTScene *scene in self.scenes) {
        [scenesHTML appendString:[scene htmlRepresentation]];
    }

    template = [template stringByReplacingOccurrencesOfString:@"%INITIAL%" withString:self.initialViewController];
    template = [template stringByReplacingOccurrencesOfString:@"%CSS_IMPORTS%" withString:cssImports];
    template = [template stringByReplacingOccurrencesOfString:@"%BODY_STYLE%" withString:bodyStyle];
    template = [template stringByReplacingOccurrencesOfString:@"%BODY%" withString:scenesHTML];

    return template;
}
@end
