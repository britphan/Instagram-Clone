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
@property (weak, nonatomic) IBOutlet UIImageView *profPicView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet PFImageView *postView;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.post) {
        self.usernameLabel.text = self.post.userID;
        self.captionLabel.text = self.post.caption;
        self.postView.file = self.post[@"image"];
        
        [self.postView loadInBackground];
    }
    
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
