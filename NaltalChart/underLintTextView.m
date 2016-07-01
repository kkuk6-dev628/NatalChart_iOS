//
//  underLintTextView.m
//  NaltalChart
//
//  Created by admin on 4/20/16.
//  Copyright (c) 2016 KangKuk. All rights reserved.
//

#import "underLintTextView.h"

@implementation underLintTextView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor = [UIColor grayColor].CGColor;
    border.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, self.frame.size.height);
    border.borderWidth = borderWidth;
    [self.layer addSublayer:border];
    self.layer.masksToBounds = YES;
//
//    UIImage* img = [UIImage imageNamed:@"downArrow"];   // non-CocoaPods
////    if (img == nil) img = [UIImage imageNamed:@"DownPicker.bundle/downArrow.png"]; // CocoaPods
//    if (img != nil) self.rightView = [[UIImageView alloc] initWithImage:img];
//    self.rightView.contentMode = UIViewContentModeScaleAspectFit;
//    self.rightView.clipsToBounds = YES;
//    [self showArrowImage:YES];
//    [self setArrowImage:img];
}


@end
