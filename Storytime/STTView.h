//
//  STTView.h
//  Storytime
//
//  Created by Jorge Cohen on 3/25/18.
//  Copyright © 2018 Jorge Cohen. All rights reserved.
//

#import "STTElement.h"
#import <Foundation/Foundation.h>

@interface STTView : NSObject <STTElement>
+ (STTView *)viewWithXMLElement:(id)element board:(STTBoard *)board;
@property (nonatomic, assign) CGRect rect;
@property (nonatomic) NSArray *subviews;
@property (nonatomic) NSString *typeName;
@end
