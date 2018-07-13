//
//  SettingsViewController.h
//  Instagram
//
//  Created by Britney Phan on 7/11/18.
//  Copyright © 2018 Britney Phan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse.h"

@interface SettingsViewController : UIViewController

- (PFFile *_Nullable)getPFFileFromImage: (UIImage * _Nullable)image;

@end
