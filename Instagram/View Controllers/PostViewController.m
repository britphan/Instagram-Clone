//
//  PostViewController.m
//  Instagram
//
//  Created by Britney Phan on 7/9/18.
//  Copyright © 2018 Britney Phan. All rights reserved.
//

#import "PostViewController.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"
#import "ComposeViewController.h"
#import "Post.h"
#import "HomeViewController.h"
#import "MBProgressHUD.h"



@interface PostViewController ()
@property (strong, nonatomic) IBOutlet UIView *postingView;

@end

@implementation PostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.thumbnailView.image = self.image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didTapCancel:(id)sender {
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ComposeViewController *homeViewController = [storyboard instantiateViewControllerWithIdentifier:@"ComposeViewController"];
    appDelegate.window.rootViewController = homeViewController;
}

- (IBAction)didTapPost:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.postingView animated:YES];
    [Post postUserImage:self.image withCaption:self.captionView.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (error == nil) {
            NSLog(@"Successfully posted image");
            [self.captionView endEditing:YES];
            
            [MBProgressHUD hideHUDForView:self.postingView animated:YES];
            
            [self.delegate didPost];
            AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            HomeViewController *homeViewController = [storyboard instantiateViewControllerWithIdentifier:@"HomeNavigationController"];
            appDelegate.window.rootViewController = homeViewController;
        } else {
            NSLog(@"Error posting image: %@", error.localizedDescription);
        }
    }];
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
