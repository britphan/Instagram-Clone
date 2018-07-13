//
//  HomeViewController.m
//  Instagram
//
//  Created by Britney Phan on 7/9/18.
//  Copyright © 2018 Britney Phan. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "PostCell.h"
#import "PostViewController.h"
#import "DetailsViewController.h"
#import "PFUser+ExtendedUser.h"
#import "PostHeader.h"
#import "MBProgressHud.h"
#import "ProfileViewController.h"
#import "DateTools.h"


@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource, PostViewControllerDelegate, PostHeaderDelegate>
@property (strong, nonatomic) NSMutableArray *posts;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation HomeViewController

NSString *CellIdentifier = @"PostCell";
NSString *HeaderViewIdentifier = @"PostHeader";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchPosts) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];

    [self.tableView registerNib:[UINib nibWithNibName:@"View" bundle:NSBundle.mainBundle] forHeaderFooterViewReuseIdentifier:@"PostHeader"];

    [self fetchPosts];
}
-(void)fetchPosts {
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query includeKey:@"author"];
    [query includeKey:@"likes"];
    
    [query orderByDescending:@"createdAt"];
    query.limit = 20;
    
    [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.posts = [NSMutableArray arrayWithArray:posts];
            
            [self.tableView reloadData];
            [MBProgressHUD hideHUDForView:self.tableView animated:YES];
            [self.refreshControl endRefreshing];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didTapLogout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error: %@", error.localizedDescription);
        }
        else {
            AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            appDelegate.window.rootViewController = loginViewController;
        }
    }];
    
}

- (IBAction)didTapCompose:(id)sender {
    [self performSegueWithIdentifier:@"composeSegue" sender:nil];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"detailSegue"]){
        DetailsViewController *detailsVC = (DetailsViewController *)[segue destinationViewController];
        PostCell *senderCell = sender;
        detailsVC.post = senderCell.post;
    }
    
    if ([segue.identifier isEqualToString:@"profileSegue"]) {
        ProfileViewController *profileVC = (ProfileViewController *) [segue destinationViewController];
        profileVC.user = sender;
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
    cell.post = self.posts[indexPath.section];
    [cell configureCell];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (void)didPost {
    [self fetchPosts];

}

-(void)postHeader:(PostHeader *)postHeader didTap:(PFUser *)user {
    [self performSegueWithIdentifier:@"profileSegue" sender:user];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.posts.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    PostHeader *headerView = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderViewIdentifier];
    headerView.delegate = self;
    Post *post = self.posts[section];
    headerView.user = post.author;
    if (post.author.image != nil) {
        headerView.profPicView.file = post.author.image;
        [headerView.profPicView loadInBackground];
    } else {
        headerView.profPicView.image = [UIImage imageNamed:@"instagram_gradient"];
    }
    
    
    headerView.profPicView.layer.cornerRadius = headerView.profPicView.frame.size.height /2;
    headerView.profPicView.layer.masksToBounds = YES;
    headerView.profPicView.layer.borderWidth = 0;
    
    headerView.usernameLabel.text = post.userID;
    headerView.dateLabel.text = [post.createdAt timeAgoSinceNow];
    
    
    UITapGestureRecognizer *profileTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:headerView action:@selector(didTapUser:)];
    [headerView addGestureRecognizer:profileTapGestureRecognizer];
    [headerView setUserInteractionEnabled:YES];
    
    
    
    /*
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    gradient.frame = headerView.borderView.bounds;
    gradient.colors = @[(id)[UIColor colorWithRed:86.0f/255.0f
                                            green:34.0f/255.0f
                                             blue:183.0f/255.0f
                                            alpha:1.0f].CGColor,
                        (id)[UIColor colorWithRed:226.0f/255.0f
                                            green:38.0f/255.0f
                                             blue:135.0f/255.0f
                                            alpha: 0.7f].CGColor,
                        (id)[UIColor colorWithRed:233.0f/255.0f
                                            green:109.0f/255.0f
                                             blue:48.0f/255.0f
                                            alpha: 0.0f].CGColor];
    gradient.startPoint = CGPointMake(0.0, 0.5);
    gradient.endPoint = CGPointMake(1.0, 0.5);
    [headerView.borderView.layer insertSublayer:gradient atIndex:0];
*/
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 64;
}

@end
