//
//  ImageViewController.m
//  Instagram-FBU
//
//  Created by aadhya on 7/9/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "ImageViewController.h"
#import "TimelineViewController.h"
#import "Parse/Parse.h"
#import "AppDelegate.h"
#import "LogInViewController.h"
#import "PFObject.h"
#import "PostImage.h"

@interface ImageViewController () < UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *CreateCaption;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *PostButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UIImageView *postImage;

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)OpenCameraButton:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;    
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    
    else {
        NSLog(@"Camera unavailable so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    self.postImage.image = [self resizeImage:originalImage withSize:CGSizeMake(400, 400)];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)didTapPost:(UIBarButtonItem *)sender {
    UIImage *resizeImage = [self resizeImage:self.postImage.image withSize:CGSizeMake(400, 400)];
    [PostImage postUserImage: resizeImage withCaption:self.CreateCaption.text withCompletion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)closeKeyboard:(id)sender {
    [self.view endEditing:YES];
}

@end
