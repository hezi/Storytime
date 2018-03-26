//
//  NSXMLElement+Storytime.h
//  Storytime
//
//  Created by Jorge Cohen on 3/25/18.
//  Copyright © 2018 Jorge Cohen. All rights reserved.
//

#import "CXMLElement.h"
#import <CoreGraphics/CoreGraphics.h>

@interface CXMLElement (Storytime)
- (CXMLElement *)elementForName:(NSString *)name;
- (NSString *)stringAttributeForName:(NSString *)name;
- (NSNumber *)numberAttributeForName:(NSString *)name;

- (CGPoint)pointValue;
- (CGRect)rectValue;
@end
