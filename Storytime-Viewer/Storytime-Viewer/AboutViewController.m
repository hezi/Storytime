//
//  AboutViewController.m
//  Storytime-Viewer
//
//  Created by Hezi Cohen on 3/26/18.
//  Copyright © 2018 Jorge Cohen. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()
@property (nonatomic) NSArray *aboutURLS;
@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.aboutURLS = @[
                       [NSURL URLWithString:@"http://twitter.com/jorgewritecode"],
                       [NSURL URLWithString:@"http://jorgecohen.codes"],
                       [NSURL URLWithString:@"https://github.com/twbs/ratchet"],
                       [NSURL URLWithString:@"https://github.com/TouchCode/TouchXML"],
                       [NSURL URLWithString:@"http://www.glyphish.com/"]
                       ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[UIApplication sharedApplication] openURL:_aboutURLS[(indexPath.section*2)+indexPath.row] options:@{} completionHandler:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
