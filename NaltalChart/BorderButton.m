//
//  BorderButton.m
//  NaltalChart
//
//  Created by admin on 4/28/16.
//  Copyright (c) 2016 KangKuk. All rights reserved.
//

#import "BorderButton.h"

@implementation BorderButton
- (void)drawRect:(CGRect)rect {
    
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor = [UIColor whiteColor].CGColor;
    border.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    border.borderWidth = borderWidth;
    [self.layer addSublayer:border];
    self.layer.masksToBounds = YES;
}
@end
