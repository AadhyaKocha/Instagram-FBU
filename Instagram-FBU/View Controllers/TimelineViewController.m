//
//  TimelineViewController.m
//  Instagram-FBU
//
//  Created by aadhya on 7/8/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "TimelineViewController.h"
#import "Parse/Parse.h"
#import "AppDelegate.h"
#import "LogInViewController.h"
#import "PostViewCell.h"
#import "PostImage.h"

@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *logOutButton;
- (IBAction)cameraButton:(id)sender;
@property (strong, nonatomic) NSMutableArray *posts;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.tableView.dataSource = self;
    //self.tableView.delegate = self;
    
    /*
     // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query whereKey:@"likesCount" lessThan:@100];
    query.limit = 20;
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
     */
}

- (IBAction)logOutAction:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LogInViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LogInViewController"];
        appDelegate.window.rootViewController = loginViewController;
    }];
}

- (IBAction)cameraButton:(id)sender {
    [self performSegueWithIdentifier:@"CameraSegue" sender:nil];
}

/*
//numberOfRows returns the number of items returned from the API
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

//cellForRow returns an instance of the custom cell with that reuse identifier with it’s elements populated with data at the index asked for
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PostViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostViewCell" forIndexPath:indexPath];
    PostImage *post = self.posts[indexPath.row];
    //cell.author.text = post.user.name;
    //cell.caption.text = post.text;
    cell.commentCount.text = [NSString stringWithFormat:@"%i", post.commentCount];
    cell.likeCount.text = [NSString stringWithFormat:@"%i", post.likeCount];
    
    //NSString *profileURLString = post.user.profileImage;
    //NSURL *profileURL = [NSURL URLWithString:profileURLString];
    
    return cell;
}
 */

/*
#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString: @"publishingSegue"]) {
        UINavigationController *navigationController = [segue destinationViewController];
        composeViewController *composeController = (composeViewController*)navigationController.topViewController;
        composeController.delegate = self;
    }
    else if ([segue.identifier isEqualToString: @"DetailsSegue"]) {
        
        DetailsViewController *detailsController = [segue destinationViewController];
        
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        PostImage *post = self.posts[indexPath.row];
        detailsController.tweet = tweet;
    }
}
*/

/*
 - (void)didTweet:(Tweet *)tweet {
 [self.tweets insertObject:tweet atIndex:0];
 [self.tableView reloadData];
 }
*/

@end
