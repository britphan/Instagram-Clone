//
//  PFUser+ExtendedUser.h
//  Instagram
//
//  Created by Britney Phan on 7/11/18.
//  Copyright © 2018 Britney Phan. All rights reserved.
//

#import "PFUser.h"
#import "Parse.h"

@interface PFUser (ExtendedUser)
@property (strong, nonatomic) PFFile *image;
@property (strong, nonatomic) NSArray *likes;

@end
