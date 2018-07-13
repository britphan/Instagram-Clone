//
//  PostHeader.m
//  Instagram
//
//  Created by Britney Phan on 7/12/18.
//  Copyright © 2018 Britney Phan. All rights reserved.
//

#import "PostHeader.h"

@implementation PostHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void) didTapUser:(UITapGestureRecognizer *)sender{
    [self.delegate postHeader:self didTap:self.user];
}

@end
