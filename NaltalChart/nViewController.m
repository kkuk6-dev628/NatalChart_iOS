//
//  nViewController.m
//  NaltalChart
//
//  Created by admin on 4/18/16.
//  Copyright (c) 2016 KangKuk. All rights reserved.
//

#import "nViewController.h"

@interface nViewController ()
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

@end

@implementation nViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initDraw];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void) initDraw{
    [self.navigationBar setBackgroundImage:[UIImage new]
                                  forBarMetrics:UIBarMetricsDefault];
//    self.navigationItem.backBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    //self.navigationBar.shadowImage = [UIImage new];
//    self.navigationBar.translucent = YES;
//    [self.navigationBar.backItem.backBarButtonItem setTitle:@"back"];
    
}
@end
