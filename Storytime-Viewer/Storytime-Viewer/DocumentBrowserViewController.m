//
//  DocumentBrowserViewController.m
//  Storytime-Viewer
//
//  Created by Jorge Cohen on 3/26/18.
//  Copyright © 2018 Jorge Cohen. All rights reserved.
//

#import "DocumentBrowserViewController.h"
#import "Document.h"
#import "DocumentViewController.h"

@interface DocumentBrowserViewController () <UIDocumentBrowserViewControllerDelegate>

@end

@implementation DocumentBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.allowsDocumentCreation = NO;
    self.allowsPickingMultipleItems = NO;

    self.additionalLeadingNavigationBarButtonItems = @[ [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"About"] style:(UIBarButtonItemStylePlain)target:self action:@selector(presentAbout:)] ];
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

#pragma mark UIDocumentBrowserViewControllerDelegate

- (void)documentBrowser:(UIDocumentBrowserViewController *)controller didPickDocumentURLs:(NSArray<NSURL *> *)documentURLs {

#if TARGET_OS_SIMULATOR
    [self presentDocumentAtURL:[NSURL fileURLWithPath:@"/Users/hezi/Development/Storytime/Storytime-Viewer/Storytime-Viewer/Base.lproj/Main.storyboard"]];
#endif

    NSURL *sourceURL = documentURLs.firstObject;
    if (!sourceURL) {
        return;
    }

    // Present the Document View Controller for the first document that was picked.
    // If you support picking multiple items, make sure you handle them all.
    [self presentDocumentAtURL:sourceURL];
}

- (void)documentBrowser:(UIDocumentBrowserViewController *)controller didImportDocumentAtURL:(NSURL *)sourceURL toDestinationURL:(NSURL *)destinationURL {
    // Present the Document View Controller for the new newly created document
    [self presentDocumentAtURL:destinationURL];
}

- (void)documentBrowser:(UIDocumentBrowserViewController *)controller failedToImportDocumentAtURL:(NSURL *)documentURL error:(NSError *_Nullable)error {
    // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
}

// MARK: Document Presentation

- (void)presentDocumentAtURL:(NSURL *)documentURL {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DocumentViewController *documentViewController = [storyBoard instantiateViewControllerWithIdentifier:@"DocumentViewController"];
    documentViewController.document = [[Document alloc] initWithFileURL:documentURL];

    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:documentViewController];

    [self presentViewController:navController animated:YES completion:nil];
}

@end
