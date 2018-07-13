//
//  LoginViewController.m
//  Instagram
//
//  Created by Britney Phan on 7/9/18.
//  Copyright © 2018 Britney Phan. All rights reserved.
//

#import "LoginViewController.h"
#import "PFUser+ExtendedUser.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    gradient.frame = self.backgroundView.bounds;
    gradient.colors = @[(id)[UIColor colorWithRed:86.0f/255.0f
                                            green:34.0f/255.0f
                                             blue:183.0f/255.0f
                                            alpha:1.0f].CGColor,
                        (id)[UIColor colorWithRed:237.0f/255.0f
                                            green:42.0f/255.0f
                                             blue:143.0f/255.0f
                                            alpha: 1.0f].CGColor,
                        (id)[UIColor colorWithRed:252.0f/255.0f
                                            green:134.0f/255.0f
                                             blue:50.0f/255.0f
                                            alpha: 1.0f].CGColor];
    gradient.startPoint = CGPointMake(0.0,0.0);
    gradient.endPoint = CGPointMake(1.0,0.5);
    
    [self.backgroundView.layer insertSublayer:gradient atIndex:0];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapSignUp:(id)sender {
    
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.usernameField.text;
    //newUser.email = self.emailField.text;
    newUser.password = self.passwordField.text;
    // call sign up function on the object
    newUser.likes = [[NSArray alloc] init];
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
}
- (IBAction)didTapLogin:(id)sender {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
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
