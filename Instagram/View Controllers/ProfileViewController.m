//
//  ProfileViewController.m
//  Instagram
//
//  Created by Britney Phan on 7/9/18.
//  Copyright © 2018 Britney Phan. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *posts;
@property (weak, nonatomic) IBOutlet PFImageView *profPicView;
@property (weak, nonatomic) IBOutlet UIButton *blueButton;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    if (self.user == nil) {
        
        self.user = [PFUser currentUser];
        
        [self.blueButton setTitle:@"Edit Profile" forState:UIControlStateNormal];
    } else if ([self.user.username isEqualToString: PFUser.currentUser.username]){
        [self.blueButton setTitle:@"Edit Profile" forState:UIControlStateNormal];
    } else {
        
        [self.blueButton setTitle:@"Follow" forState:UIControlStateNormal];
    }
    
    
    self.profPicView.file = self.user.image;
    self.usernameLabel.text = self.user.username;
    
    [self.profPicView loadInBackground];
    
    self.profPicView.layer.cornerRadius = self.profPicView.frame.size.height /2;
    self.profPicView.layer.masksToBounds = YES;
    self.profPicView.layer.borderWidth = 0;
    
    UICollectionViewFlowLayout *layout =(UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    
    CGFloat postersPerLine = 3;
    CGFloat itemWidth = (self.collectionView.frame.size.width - layout.minimumInteritemSpacing * (postersPerLine - 1)) / postersPerLine;
    CGFloat itemHeight = itemWidth;
    
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    [self fetchPosts];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fetchPosts {
    
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query whereKey:@"author" equalTo:self.user];
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.posts = [NSMutableArray arrayWithArray:posts];
            NSLog(@"posts: %@",posts);
            [self.collectionView reloadData];
            
            //[self.refreshControl endRefreshing];
        } else {
            NSLog(@"%@", error.localizedDescription);
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

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCollectionCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"PostCollectionCell" forIndexPath:indexPath];
    cell.post = self.posts[indexPath.item];
    NSLog(@"just got post: %@", cell.post.caption);
    [cell configureCell];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.posts.count;
}
- (IBAction)didTapButton:(id)sender {
    if ([self.user.username isEqualToString: PFUser.currentUser.username]){
        [self performSegueWithIdentifier:@"settingsSegue" sender:nil];
    }
    /*else {
        [self followUser:self.user];
    }*/
}
/*
- (void) followUser:(PFUser*) user{
    [PFUser.currentUser addObject:user.username forKey:@"following"];
    [self.user addObject:PFUser.currentUser forKey:@"followers"];
    [PFUser.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        
    }];

}*/
@end
