//
//  STTViewController.h
//  Storytime
//
//  Created by Jorge Cohen on 3/25/18.
//  Copyright © 2018 Jorge Cohen. All rights reserved.
//

#import "STTElement.h"
#import <Foundation/Foundation.h>

@class STTBoard, STTNavigationItem, STTView;

@interface STTViewController : NSObject <STTElement>
@property (nonatomic) NSString *typeName;
@property (nonatomic) NSString *identifier;
@property (nonatomic) NSString *className;
@property (nonatomic, assign) CGRect rect;
@property (nonatomic) STTNavigationItem *navigationItem;
@property (nonatomic) STTView *rootView;
@end
