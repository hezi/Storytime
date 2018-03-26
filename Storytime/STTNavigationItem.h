//
//  STTNavigationItem.h
//  Storytime
//
//  Created by Jorge Cohen on 3/25/18.
//  Copyright © 2018 Jorge Cohen. All rights reserved.
//

#import "STTElement.h"
#import <Foundation/Foundation.h>

@interface STTNavigationItem : NSObject <STTElement>
@property (nonatomic) NSString *title;
@property (nonatomic) NSArray *buttons;
@end
