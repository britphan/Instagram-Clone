//
//  PostCell.h
//  Instagram
//
//  Created by Britney Phan on 7/9/18.
//  Copyright © 2018 Britney Phan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "ParseUI.h"
#import "PFUser+ExtendedUser.h"

@interface PostCell : UITableViewCell
@property (strong,nonatomic) Post *post;
//@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property (weak, nonatomic) IBOutlet PFImageView *postView;
//@property (weak, nonatomic) IBOutlet PFImageView *profPicView;



-(void)configureCell;
@end

