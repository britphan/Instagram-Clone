//
//  PostCollectionCell.m
//  Instagram
//
//  Created by Britney Phan on 7/11/18.
//  Copyright © 2018 Britney Phan. All rights reserved.
//

#import "PostCollectionCell.h"

@implementation PostCollectionCell

- (void) configureCell {
    self.postView.file = self.post[@"image"];
    
    [self.postView loadInBackground];
}

@end
