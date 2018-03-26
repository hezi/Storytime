//
//  Document.m
//  Storytime-Viewer
//
//  Created by Jorge Cohen on 3/26/18.
//  Copyright © 2018 Jorge Cohen. All rights reserved.
//

#import "Document.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <StorytimeiOS/StorytimeiOS.h>

@implementation Document

- (id)contentsForType:(NSString *)typeName error:(NSError **)errorPtr {
    // Encode your document with an instance of NSData or NSFileWrapper
    return [[NSData alloc] init];
}

- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError **)errorPtr {
    NSString *uti = (__bridge NSString *)(UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef _Nonnull)(self.fileURL.pathExtension), nil));

    NSLog(@"%@", uti);
    NSData *data = contents;
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    STTBoard *board = [[STTBoard alloc] initWithXMLString:string];
    self.htmlString = board.htmlRepresentation;
    return YES;
}

@end
