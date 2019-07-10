//
//  PostImage.h
//  Instagram-FBU
//
//  Created by aadhya on 7/9/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "PFObject.h"
#import "Parse/Parse.h"
//#import "PostViewCell.h"
//#import "PostImage.h"
//#import "TimelineViewController.h"

/*
@protocol ComposeViewControllerDelegate
- (void)didTapPost:(PostImage *)post;
@end
 */

@interface PostImage : PFObject <PFSubclassing>

@property (nonatomic, strong) NSString *postID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) PFUser *author;

@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) PFFileObject *image;
@property (nonatomic, strong) NSNumber *likeCount;
@property (nonatomic, strong) NSNumber *commentCount;

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion;

@end
