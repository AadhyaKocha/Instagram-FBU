//
//  DetailsViewController.h
//  Instagram-FBU
//
//  Created by aadhya on 7/10/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostImage.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController

@property (nonatomic, strong) PostImage *post;

@end

NS_ASSUME_NONNULL_END
