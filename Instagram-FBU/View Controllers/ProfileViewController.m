//
//  ProfileViewController.m
//  Instagram-FBU
//
//  Created by aadhya on 7/11/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "ProfileViewController.h"
#import "PostImage.h"
#import "Parse/Parse.h"
#import "PostCollectionCell.h"

@interface ProfileViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) NSArray *posts;
@property (weak, nonatomic) IBOutlet UIImageView *ProfilePicture;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self fetchPosts];
    
    PFUser *currentUser = [PFUser currentUser];
    self.username.text = [currentUser username];
    
    [currentUser[@"profileImage"] getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (!error) {
            self.ProfilePicture.image = [UIImage imageWithData:data];
        }
    }];

    self.ProfilePicture.layer.cornerRadius = self.ProfilePicture.frame.size.width / 2;
    self.ProfilePicture.clipsToBounds = YES;
    
    /*
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.collectionView.collectionViewLayout;
    CGFloat postersPerLine = 3;
    CGFloat itemWidth = (self.collectionView.frame.size.width - layout.minimumInteritemSpacing * (postersPerLine - 1))  / postersPerLine;
    CGFloat itemHeight = itemWidth;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
     */
}

- (void)fetchPosts {
    // construct PFQuery
    PFQuery *postQuery = [PostImage query];
    PFUser *currentUser = [PFUser currentUser];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery whereKey:@"author" equalTo:currentUser];
    NSArray *userPosts = [postQuery findObjects];
    postQuery.limit = 20;
    
    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<PostImage *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            self.posts = (NSMutableArray *)userPosts;
            [self.collectionView reloadData];
        }
        else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (IBAction)didTapProfilePicture:(id)sender {
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
    
    self.ProfilePicture.image = [self resizeImage:originalImage withSize:CGSizeMake(400, 400)];
    
    PFFileObject *profilePic = [PostImage getPFFileFromImage:self.ProfilePicture.image];
    PFUser *currentUser = [PFUser currentUser];
    
    currentUser[@"profileImage"] = profilePic;
    [currentUser saveInBackground];
    
    self.ProfilePicture.image = editedImage;
    
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

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PostCollectionCell" forIndexPath:indexPath];
    
    PostImage *post = self.posts[indexPath.item];
    
    [post.image getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (!error) {
            cell.posterView.image = [UIImage imageWithData:data];
        }
    }];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.posts.count;
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
