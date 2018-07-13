//
//  ProfileViewController.h
//  Instagram
//
//  Created by Britney Phan on 7/9/18.
//  Copyright © 2018 Britney Phan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostCollectionCell.h"
#import <Parse/Parse.h>
#import "PFUser+ExtendedUser.h"

@interface ProfileViewController : UIViewController

@property (strong, nonatomic) PFUser *user;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bioLabel;

@end
