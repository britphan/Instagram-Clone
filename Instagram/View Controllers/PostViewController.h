//
//  PostViewController.h
//  Instagram
//
//  Created by Britney Phan on 7/9/18.
//  Copyright © 2018 Britney Phan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostViewController : UIViewController
@property (strong, nonatomic) UIImage * image;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;
@property (weak, nonatomic) IBOutlet UITextView *captionView;
@end
