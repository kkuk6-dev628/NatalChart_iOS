//
//  NatalParamControllerViewController.h
//  NaltalChart
//
//  Created by admin on 4/19/16.
//  Copyright (c) 2016 KangKuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownPicker.h"
#import "NHMainHeader.h"

@class UICheckbox;
@interface NatalParamControllerViewController : UIViewController<NHAutoCompleteTextFieldDataSourceDelegate, NHAutoCompleteTextFieldDataFilterDelegate,NSURLConnectionDelegate, NSURLConnectionDataDelegate>
{
    NHAutoCompleteTextField *autoCompleteTextField;
    NSArray *inUseDataSource;
    NSMutableArray *parentDataSource;   
    NSURLConnection *connection;
    
//    NSNetServiceBrowser* browser;
//    NSMutableArray* services;
}
@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UITextField *txtBirtDate;
@property (weak, nonatomic) IBOutlet UITextField *txtBirthTime;
@property (weak, nonatomic) IBOutlet UIScrollView *mScrollView;
@property (weak, nonatomic) IBOutlet UITextField *cmbCity;
@property (weak, nonatomic) IBOutlet UICheckbox *checkBox;
@property (weak, nonatomic) IBOutlet UITextField *cmbCountry;
@property (nonatomic) DownPicker *countryPicker;
@property (nonatomic, retain) NSDictionary * countrySource;
@property (weak, nonatomic) IBOutlet UILabel *lblCity;
@property (weak, nonatomic) IBOutlet UIView *advanceView;
@property (weak, nonatomic) IBOutlet UIView *lngView;
@property (weak, nonatomic) IBOutlet UIView *latView;
@property (weak, nonatomic) IBOutlet UITextField *txtLat;
@property (weak, nonatomic) IBOutlet UITextField *txtLng;
@property (weak, nonatomic) IBOutlet UITextField *txtTime;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
- (IBAction)clickSubmit:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationItem *mNavItem;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *mProgressView;
@property (nonatomic, retain) NSMutableArray * countrys;
-(IBAction)testCheckbox:(id)sender;
-(IBAction)changeCountry:(id)sender;

@end
