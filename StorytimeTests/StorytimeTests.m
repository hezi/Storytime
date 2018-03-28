//
//  StorytimeTests.m
//  StorytimeTests
//
//  Created by Jorge Cohen on 3/25/18.
//  Copyright © 2018 Jorge Cohen. All rights reserved.
//

#import "STTBoard.h"
#import <XCTest/XCTest.h>

@interface StorytimeTests : XCTestCase

@end

@implementation StorytimeTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    NSURL *storyURL = [NSURL fileURLWithPath:@"/Users/hezi/Desktop/storyboard.storyboard"]; //@"/Users/hezi/TalkTheTime/TalkTheTime/Base.lproj/Main.storyboard"
    STTBoard *board = [[STTBoard alloc] initWithURL:storyURL];

    [[board htmlRepresentation] writeToURL:[NSURL URLWithString:@"file:///Users/hezi/Desktop/untitles.html"] atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
