//
//  DetailsViewController.m
//  Instagram-FBU
//
//  Created by aadhya on 7/10/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "DetailsViewController.h"
#import "PostImage.h"
#import "PostViewCell.h"
#import "TimelineViewController.h"
#import "DateTools.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property (weak, nonatomic) IBOutlet UILabel *commentCount;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@property (weak, nonatomic) IBOutlet UILabel *usernameCaption;
@property (weak, nonatomic) IBOutlet UILabel *caption;
@property (weak, nonatomic) IBOutlet UILabel *date;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.caption.text = self.post.caption;
    self.username.text = self.post.author.username;
    self.usernameCaption.text = self.post.author.username;
    self.commentCount.text = [NSString stringWithFormat:@"%@", self.post.commentCount];
    self.likeCount.text = [NSString stringWithFormat:@"%@", self.post.likeCount];
    
    [self.post.author[@"profileImage"] getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (!error) {
            self.profileImage.image = [UIImage imageWithData:data];
        }
    }];
    self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2;
    self.profileImage.clipsToBounds = YES;
    
    [self.post.image getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (!error) {
            self.postImage.image = [UIImage imageWithData:data];
        }
    }];
    NSString *createdAtOriginalString = self.date.text = [NSString stringWithFormat:@"%@", self.post.createdAt];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // Configure the input format to parse the date string
    formatter.dateFormat = @"YYYY-MM-dd HH:mm:ss z";
    // Convert String to Date
    NSDate *date = [formatter dateFromString:createdAtOriginalString];
    NSDate *now = [NSDate date];
    NSInteger timeApart = [now hoursFrom:date];
    NSLog(@"timeApart: %li; date: %@; now: %@", timeApart, date, now);
    
    if (timeApart >= 24) {
        formatter.dateStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
        self.date.text = [formatter stringFromDate:date];
    }
    else {
        self.date.text = date.shortTimeAgoSinceNow;
    }
    
    if ([self.post.likeCount intValue] >= 1) {
        [self.likeButton setImage:[UIImage imageNamed:@"red-like"] forState:UIControlStateNormal];
    }
    else if ([self.post.likeCount intValue] == 0) {
        [self.likeButton setImage:[UIImage imageNamed:@"like-insta"] forState:UIControlStateNormal];
    }
}

- (IBAction)didTapFavorite:(id)sender {
    if ([self.post.likeCount intValue] == 0) {
        
        NSNumber *number = self.post.likeCount; //[NSNumber numberWithInt:[self.post.likeCount intValue]];
        int value = [number intValue];
        number = [NSNumber numberWithInt:value + 1];
        //[self.post.likeCount intValue] = number;
        self.likeCount.text = [NSString stringWithFormat:@"%@", number];
        [self.likeButton setImage:[UIImage imageNamed:@"red-like"] forState: UIControlStateNormal];
        [self.post setValue:number forKey:@"likeCount"];
        [self.post saveInBackground];
    }
    
    else if ([self.post.likeCount intValue] >= 1) {
        //self.post.likeCount = NO;
        
        NSNumber *number = [NSNumber numberWithInt:[self.post.likeCount intValue]];
        int value = [self.post.likeCount intValue];
        number = [NSNumber numberWithInt:value - 1];
        //[self.post.likeCount intValue] = number;
        self.likeCount.text = [NSString stringWithFormat:@"%@", number];
        [self.likeButton setImage:[UIImage imageNamed:@"like-insta"] forState: UIControlStateNormal];
        [self.post setValue:number forKey:@"likeCount"];
        [self.post saveInBackground];
    }
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
