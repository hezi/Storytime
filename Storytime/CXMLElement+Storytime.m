//
//  NSXMLElement+Storytime.m
//  Storytime
//
//  Created by Jorge Cohen on 3/25/18.
//  Copyright © 2018 Jorge Cohen. All rights reserved.
//

#import "CXMLElement+Storytime.h"

@implementation CXMLElement (Storytime)
- (CXMLElement *)elementForName:(NSString *)name {
    NSArray *elements = [self elementsForName:name];

    if (elements.count > 0)
        return elements[0];

    return nil;
}

- (NSString *)stringAttributeForName:(NSString *)name {
    return [self attributeForName:name].stringValue;
}

- (NSNumber *)numberAttributeForName:(NSString *)name {
    return (NSNumber *)@([self attributeForName:name].stringValue.floatValue);
}

- (CGPoint)pointValue {
    NSNumber *x = [self numberAttributeForName:@"x"];
    NSNumber *y = [self numberAttributeForName:@"y"];

    return CGPointMake(x.floatValue, y.floatValue);
}

- (CGRect)rectValue {
    NSNumber *x = [self numberAttributeForName:@"x"];
    NSNumber *y = [self numberAttributeForName:@"y"];
    NSNumber *width = [self numberAttributeForName:@"width"];
    NSNumber *height = [self numberAttributeForName:@"height"];

    return CGRectMake(x.floatValue, y.floatValue, width.floatValue, height.floatValue);
}

@end
