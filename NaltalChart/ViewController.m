//
//  ViewController.m
//  NaltalChart
//
//  Created by admin on 4/18/16.
//  Copyright (c) 2016 KangKuk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnClose;
- (IBAction)closeApp:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self drawRect];
//    self.navigationController.navigationBar.topItem.title = @"Natal Chart";
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationItem.title = @"Natal Chart";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)drawRect{
//    [self.navigationBar setBackgroundImage:[UIImage new]
//                             forBarMetrics:UIBarMetricsDefault];
//    self.navigationBar.shadowImage = [UIImage new];
//    self.navigationBar.translucent = YES;
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(__bridge id)[kTopBackgroundColor CGColor],
                       (__bridge id)[kBottomBackgroundColor CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
}

- (IBAction)closeApp:(id)sender {
    exit(0);
}
@end
