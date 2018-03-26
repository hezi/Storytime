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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.document openWithCompletionHandler:^(BOOL success) {
        if (success) {
            // Display the content of the document, e.g.:
            self.title = [self.document.fileURL lastPathComponent];
            [self.webView loadHTMLString:self.document.htmlString baseURL:[[NSBundle bundleForClass:self.class] bundleURL]];
        } else {
            // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];

}

- (IBAction)presentAbout:(id)sender {
    UIViewController *aboutViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"AboutViewController"];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:aboutViewController];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        navController.modalPresentationStyle = UIModalPresentationPopover;
        [self presentViewController:navController animated:YES completion:nil];
        navController.popoverPresentationController.barButtonItem = sender;
        
    } else {
        [self presentViewController:navController animated:YES completion:nil];
    }
}

- (IBAction)dismissDocumentViewController {
    [self dismissViewControllerAnimated:YES
                             completion:^{
                                 [self.document closeWithCompletionHandler:nil];
                             }];
}

@end
