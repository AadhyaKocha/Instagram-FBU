//
//  LogInViewController.m
//  Instagram-FBU
//
//  Created by aadhya on 7/8/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "LogInViewController.h"
#import "Parse/Parse.h"

@interface LogInViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
- (IBAction)loginUser:(id)sender;

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)loginUser:(id)sender {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
           [self performSegueWithIdentifier:@"logInSegue" sender:nil];
            
           //self.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"TabBarVC"];
        }
    }];
}

- (IBAction)shutKeyboard:(id)sender {
    [self.view endEditing:YES];
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
