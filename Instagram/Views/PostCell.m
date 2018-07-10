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
    self.usernameLabel.text = self.post.userID;
    self.captionLabel.text = self.post.caption;
    self.postView.file = self.post[@"image"];
    
    [self.postView loadInBackground];
}
- (IBAction)didTapLike:(id)sender {
    /*
     if (self.likeButton.selected) {
        self.likeButton.selected = NO;
    } else {
        self.likeButton.selected = YES;
    }
     */
}

@end
