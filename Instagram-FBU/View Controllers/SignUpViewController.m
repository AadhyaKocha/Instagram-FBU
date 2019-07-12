//
//  SignUpViewController.m
//  Instagram-FBU
//
//  Created by aadhya on 7/8/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "SignUpViewController.h"
#import "Parse/Parse.h"
#import "AppDelegate.h"

@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
- (IBAction)signUpUser:(id)sender;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)signUpUser:(id)sender {
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.usernameField.text;
    newUser.email = self.emailField.text;
    newUser.password = self.passwordField.text;
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            //[self performSegueWithIdentifier:@"signUpSegue" sender:nil];
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            SignUpViewController *SignUpViewController = [storyboard instantiateViewControllerWithIdentifier:@"TabBarVC"];
            appDelegate.window.rootViewController = SignUpViewController;
        }
    }];
}

- (IBAction)shutKeyboard:(id)sender {
    [self.view endEditing:YES];
}

@end
