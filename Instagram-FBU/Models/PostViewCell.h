//
//  PostViewCell.h
//  Instagram-FBU
//
//  Created by aadhya on 7/9/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostImage.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIImageView *PostImage;
@property (weak, nonatomic) IBOutlet UILabel *commentCount;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property (weak, nonatomic) IBOutlet UILabel *caption;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UILabel *authorCaption;
@property (weak, nonatomic) IBOutlet UILabel *Date;
@property (strong, nonatomic) PostImage *post;

@property (weak, nonatomic) IBOutlet UILabel *favorited;
@property (weak, nonatomic) IBOutlet UILabel *commented;

@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@end

NS_ASSUME_NONNULL_END
