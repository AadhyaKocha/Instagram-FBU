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
#import "ImageViewController.h"
#import "DetailsViewController.h"
#import "DateTools.h"

@interface TimelineViewController () <ImageViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *logOutButton;
- (IBAction)cameraButton:(id)sender;
@property (strong, nonatomic) NSMutableArray *posts;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self fetchPosts];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchPosts) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

- (void)fetchPosts {
    // construct PFQuery
    PFQuery *postQuery = [PostImage query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = 20;

    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<PostImage *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            self.posts = posts;
            [self.tableView reloadData];
        }
        else {
            NSLog(@"%@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
    }];
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

//numberOfRows returns the number of items returned from the API
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PostViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostViewCell" forIndexPath:indexPath];
    
    PostImage *post = self.posts[indexPath.row];
    cell.caption.text = post.caption;
    cell.author.text = post.author.username;
    cell.authorCaption.text = post.author.username;
    cell.commentCount.text = [NSString stringWithFormat:@"%@", post.commentCount];
    cell.likeCount.text = [NSString stringWithFormat:@"%@", post.likeCount];
    
    [post.image getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (!error) {
            cell.PostImage.image = [UIImage imageWithData:data];
        }
    }];
    
    NSString *createdAtOriginalString = cell.Date.text = [NSString stringWithFormat:@"%@", post.createdAt];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // Configure the input format to parse the date string
    formatter.dateFormat = @"YYYY-MM-dd HH:mm:ss z";
    // Convert String to Date
    NSDate *date = [formatter dateFromString:createdAtOriginalString];
    NSDate *now = [NSDate date];
    NSInteger timeApart = [now hoursFrom:date];
    
    if (timeApart >= 24) {
        formatter.dateStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
        cell.Date.text = [formatter stringFromDate:date];
    }
    else {
        cell.Date.text = date.shortTimeAgoSinceNow;
    }
    
    if ([post.likeCount intValue] == 1) {
        [cell.favoriteButton setImage:[UIImage imageNamed:@"red-like"] forState:UIControlStateNormal];
    }
    else if ([post.likeCount intValue] == 0) {
        [cell.favoriteButton setImage:[UIImage imageNamed:@"like-insta"] forState:UIControlStateNormal];
    }
    
    return cell;
}

- (void)didPost:(PostImage *)post {
    [self.posts insertObject:post atIndex:0];
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString: @"cameraSegue"]) {
        UINavigationController *navigationController = [segue destinationViewController];
        ImageViewController *ImageController = (ImageViewController*)navigationController.topViewController;
        ImageController.delegate = self;
    }
    
    else if ([segue.identifier isEqualToString: @"detailSegue"]) {
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        PostImage *post = self.posts[indexPath.row];
        DetailsViewController *detailsViewController = [segue destinationViewController];
        detailsViewController.post =post;
    }
}

@end
