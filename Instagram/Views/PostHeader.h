//
//  PostHeader.h
//  Instagram
//
//  Created by Britney Phan on 7/12/18.
//  Copyright © 2018 Britney Phan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse.h"
#import "ParseUI.h"
#import "PFUser+ExtendedUser.h"
#import "DateTools.h"

@protocol PostHeaderDelegate;

@interface PostHeader : UITableViewHeaderFooterView

//@property (weak, nonatomic) IBOutlet PFImageView *profPicView;
//@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet PFImageView *profPicView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIView *borderView;
@property (strong, nonatomic) id<PostHeaderDelegate> delegate;
@property (strong, nonatomic) PFUser* user;
@end


@protocol PostHeaderDelegate
- (void)postHeader:(PostHeader *) postHeader didTap: (PFUser *)user;
@end
