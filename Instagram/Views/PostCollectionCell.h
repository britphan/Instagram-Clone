//
//  PostCollectionCell.h
//  Instagram
//
//  Created by Britney Phan on 7/11/18.
//  Copyright © 2018 Britney Phan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>

@interface PostCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet PFImageView *postView;

@property (strong, nonatomic) Post* post;

- (void) configureCell;
@end
