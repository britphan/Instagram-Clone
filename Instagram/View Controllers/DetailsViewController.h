//
//  DetailsViewController.h
//  Instagram
//
//  Created by Britney Phan on 7/10/18.
//  Copyright © 2018 Britney Phan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "PFUser+ExtendedUser.h"
#import "DateTools.h"

@interface DetailsViewController : UIViewController
@property (strong, nonatomic) Post *post;
@end
