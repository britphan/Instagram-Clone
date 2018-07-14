//
//  DetailsViewController.m
//  Instagram
//
//  Created by Britney Phan on 7/10/18.
//  Copyright © 2018 Britney Phan. All rights reserved.
//

#import "DetailsViewController.h"
#import "ParseUI.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet PFImageView *postView;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet PFImageView *profPicView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.post) {
        self.usernameLabel.text = self.post.userID;
        self.captionLabel.text = self.post.caption;
        self.postView.file = self.post[@"image"];
        
        [self.postView loadInBackground];
        self.profPicView.file = self.post.author.image;
        
        
        self.profPicView.layer.cornerRadius = self.profPicView.frame.size.height /2;
        self.profPicView.layer.masksToBounds = YES;
        self.profPicView.layer.borderWidth = 0;
        [self.profPicView loadInBackground];
        
        self.dateLabel.text = [self.post.createdAt timeAgoSinceNow];
        
        
        NSArray *likes = self.post.likes;
        if([likes containsObject:PFUser.currentUser.username]) {
            
            NSLog(@"liked post by %@",self.post.userID);
            self.likeButton.selected = YES;
        }
        else {
            
            self.likeButton.selected = NO;
        }
        if ([self.post.likeCount isEqualToValue:[NSNumber numberWithInteger:1]]) {
            
            self.likeCount.text = [NSString stringWithFormat:@"%@ like",self.post.likeCount];
        } else {
            
            self.likeCount.text = [NSString stringWithFormat:@"%@ likes",self.post.likeCount];
        }
    }
    
    
    
}
- (IBAction)didTapLike:(id)sender {
    if([self.post.likes containsObject: [PFUser currentUser].username]) {
        
        self.likeButton.selected = NO;
        //[[PFUser currentUser] removeObject:self.post.postID forKey:@"likes"];
        [self.post removeObject:PFUser.currentUser.username forKey:@"likes"];
        [self.post incrementKey:@"likeCount" byAmount:[NSNumber numberWithInteger:-1]];
    } else {
        
        //[[PFUser currentUser] addUniqueObject:self.post forKey:@"likes"];
        [self.post addUniqueObject:[PFUser currentUser].username forKey:@"likes"];
        self.likeButton.selected = YES;
        [self.post incrementKey:@"likeCount"];
    }
    if ([self.post.likeCount isEqualToValue:[NSNumber numberWithInt:1]]) {
        
        self.likeCount.text = [NSString stringWithFormat:@"%@ like",self.post.likeCount];
    } else {
        
        self.likeCount.text = [NSString stringWithFormat:@"%@ likes",self.post.likeCount];
    }
    
    [self.post saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Error liking post: %@", error.localizedDescription);
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
