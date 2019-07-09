//
//  TimelineViewController.m
//  Instagram-FBU
//
//  Created by aadhya on 7/8/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "TimelineViewController.h"
#import "Parse/Parse.h"

@interface TimelineViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *logOutButton;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)logOutAction:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
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
