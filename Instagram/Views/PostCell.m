//
//  PostCell.m
//  Instagram
//
//  Created by Britney Phan on 7/9/18.
//  Copyright © 2018 Britney Phan. All rights reserved.
//

#import "PostCell.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureCell {
    //self.usernameLabel.text = self.post.userID;
    self.captionLabel.text = self.post.caption;
    self.postView.file = self.post[@"image"];
    
    [self.postView loadInBackground];
    //self.profPicView.file = self.post.author.image;
    //[self.profPicView loadInBackground];
    NSArray *likes = PFUser.currentUser.likes;
    if([likes containsObject:self.post]) {
        
        NSLog(@"liked post by %@",self.post.userID);
        self.likeButton.selected = YES;
    }
    else {
        
        self.likeButton.selected = NO;
    }
    self.likeCount.text = [NSString stringWithFormat:@"%@",self.post.likeCount];
}
- (IBAction)didTapLike:(id)sender {
    if([self.post.likes containsObject: [PFUser currentUser]]) {
        
        self.likeButton.selected = NO;
        [[PFUser currentUser] removeObject:self.post forKey:@"likes"];
        [self.post removeObject:[PFUser currentUser] forKey:@"likes"];
        [self.post incrementKey:@"likeCount" byAmount:[NSNumber numberWithInteger:-1]];
        self.likeCount.text = [NSString stringWithFormat:@"%@",self.post.likeCount];
    } else {
        
        [[PFUser currentUser] addUniqueObject:self.post forKey:@"likes"];
        [self.post addUniqueObject:[PFUser currentUser] forKey:@"likes"];
        self.likeButton.selected = YES;
        [self.post incrementKey:@"likeCount"];
        self.likeCount.text = [NSString stringWithFormat:@"%@",self.post.likeCount];
    }
    
    [self.post saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Error liking post: %@", error.localizedDescription);
        }
    }];
    
    
    [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Error adding post to likes: %@", error.localizedDescription);
        }
    }];
}

@end
