//
//  DocumentViewController.m
//  Storytime-Viewer
//
//  Created by Jorge Cohen on 3/26/18.
//  Copyright © 2018 Jorge Cohen. All rights reserved.
//

#import "DocumentViewController.h"
#import <WebKit/WebKit.h>

@interface DocumentViewController ()
@property (weak, nonatomic) IBOutlet WKWebView *webView;
@end

@implementation DocumentViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // Access the document
    [self.document openWithCompletionHandler:^(BOOL success) {
        if (success) {
            // Display the content of the document, e.g.:
            self.title = [self.document.fileURL lastPathComponent];
            [self.webView loadHTMLString:self.document.htmlString baseURL:[[NSBundle bundleForClass:self.class] bundleURL]];
        } else {
            // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
        }
    }];
}

- (IBAction)dismissDocumentViewController {
    [self dismissViewControllerAnimated:YES
                             completion:^{
                                 [self.document closeWithCompletionHandler:nil];
                             }];
}

@end
