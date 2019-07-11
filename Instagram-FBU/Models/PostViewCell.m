//
//  PostViewCell.m
//  Instagram-FBU
//
//  Created by aadhya on 7/9/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "PostViewCell.h"
#import "PostImage.h"
#import "TimelineViewController.h"

@implementation PostViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)didTapFavorite:(id)sender {
    
    if ([self.post.likeCount intValue] == 0) {
        
        NSNumber *number = self.post.likeCount; //[NSNumber numberWithInt:[self.post.likeCount intValue]];
        int value = [number intValue];
        number = [NSNumber numberWithInt:value + 1];
        //[self.post.likeCount intValue] = number;
        self.likeCount.text = [NSString stringWithFormat:@"%@", number];
        [self.favoriteButton setImage:[UIImage imageNamed:@"red-like"] forState: UIControlStateNormal];
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
         [self.favoriteButton setImage:[UIImage imageNamed:@"like-insta"] forState: UIControlStateNormal];
         [self.post setValue:number forKey:@"likeCount"];
         [self.post saveInBackground];
     }
}

@end
