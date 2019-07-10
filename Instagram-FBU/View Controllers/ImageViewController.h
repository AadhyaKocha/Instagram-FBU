//
//  ImageViewController.h
//  Instagram-FBU
//
//  Created by aadhya on 7/9/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostImage.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ImageViewControllerDelegate
- (void)didPost:(PostImage *)post;
@end

@interface ImageViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) id<ImageViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
