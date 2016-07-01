//
//  NatalParamControllerViewController.m
//  NaltalChart
//
//  Created by admin on 4/19/16.
//  Copyright (c) 2016 KangKuk. All rights reserved.
//

#import "NatalParamControllerViewController.h"
#import "ViewController.h"
#import "UICheckbox.h"
#import <sqlite3.h>
#import "ChartViewController.h"
@interface NatalParamControllerViewController ()

@end

@implementation NatalParamControllerViewController
#define kCellIdentifier @"cellIdentifier"
@synthesize countrySource;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.topItem.title = @"";
    [self drawRect];    
//    [self.advanceView setHidden:TRUE];

    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceReferenceDate:-3124184400];
                                                                           
    datePicker.maximumDate = [NSDate dateWithTimeIntervalSinceReferenceDate:599482800];
    [datePicker setDate:[NSDate dateWithTimeIntervalSinceReferenceDate:-1600029252]];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(dateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.txtBirtDate setInputView:datePicker];
    
    UIDatePicker *timePicker = [[UIDatePicker alloc]init];
    [timePicker setDate:[NSDate date]];
    timePicker.datePickerMode = UIDatePickerModeTime;
    [timePicker addTarget:self action:@selector(timeTextField:) forControlEvents:UIControlEventValueChanged];
    [self.txtBirthTime setInputView:timePicker];
    
    if ([countrySource count] < 1)
    {
        [self getCountryAllData];
    }
    self.countryPicker = [[DownPicker alloc] initWithTextField:self.cmbCountry withData:self.countrys];

    self.checkBox.checked = FALSE;
    self.checkBox.disabled = FALSE;
    self.checkBox.text = @"Don't Know";
    // Do any additional setup after loading the view.
    
    autoCompleteTextField = [[NHAutoCompleteTextField alloc] initWithFrame:CGRectMake(10, 338, self.view.frame.size.width -20, 30)];
    [autoCompleteTextField setDropDownDirection:NHDropDownDirectionUp];
    [autoCompleteTextField setDataSourceDelegate:self];
    [autoCompleteTextField setDataFilterDelegate:self];
    
    
    [self.mScrollView addSubview:autoCompleteTextField];
    
    self.txtEmail.keyboardType = UIKeyboardTypeEmailAddress;
    [self.mProgressView setHidden:YES];
}
-(void) dateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.txtBirtDate.inputView;
    [picker setMaximumDate:[NSDate date]];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *eventDate = picker.date;
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    self.txtBirtDate.text = [NSString stringWithFormat:@"%@",dateString];
}
-(void) timeTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.txtBirthTime.inputView;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *eventDate = picker.date;
    [dateFormat setDateFormat:@"HH:mm"];
    
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    self.txtBirthTime.text = [NSString stringWithFormat:@"%@",dateString];
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
- (void)getCountryAllData {
    // Getting the database path.
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *dbPath = [docsPath stringByAppendingPathComponent:@"natal.db"];
    
    const char *dbpath = [dbPath UTF8String];
    sqlite3_stmt    *statement;
    sqlite3 * mapDB;
    if (sqlite3_open(dbpath, &mapDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT name, code FROM countries WHERE active = '1' ORDER BY name"];
        
        const char *query_stmt = [querySQL UTF8String];
        self.countrys = [NSMutableArray new];
        NSMutableArray *codes = [NSMutableArray new];
        if (sqlite3_prepare_v2(mapDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *cityN = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                NSString *code = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                
                [self.countrys addObject:cityN];
                [codes addObject:code];
            }
            sqlite3_finalize(statement);
            
        }
        sqlite3_close(mapDB);
        if ([self.countrys count] > 0) {
            countrySource  = [NSDictionary dictionaryWithObjects:codes forKeys:self.countrys];
            
        }
    }
    
}
-(void)alertViewShow:(NSString*)error
{
    NSString* alertMessage = [NSString stringWithFormat:@"Invalid %@" , error];
    UIAlertView* authenticationAlert = [[UIAlertView alloc] initWithTitle:@"Authentication failed"
       message:alertMessage
       delegate:nil
       cancelButtonTitle:@"OK"
       otherButtonTitles:nil];
    [authenticationAlert show];
    

}
- (void)drawRect{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(__bridge id)[kTopBackgroundColor CGColor],
                       (__bridge id)[kBottomBackgroundColor CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
}
-(IBAction)testCheckbox:(id)sender {
    (self.checkBox.checked) ? [self.txtBirthTime setText:@"12:00"] : [self.txtBirthTime setText:@""];
    }
-(IBAction)changeCountry:(id)sender;{
    [self clearParameter];
    if ([self.txtUsername.text isEqualToString:@""]) {
        [self alertViewShow:@"User Name"];
        self.cmbCountry.text = @"";
        [self.txtUsername resignFirstResponder];
        [autoCompleteTextField setText:@""];
        return;
    }

    if ([self.txtBirtDate.text isEqualToString:@""]) {
        [self alertViewShow:@"Birth Date"];
        self.cmbCountry.text = @"";
        [autoCompleteTextField setText:@""];
        [self.txtBirtDate resignFirstResponder];
        return;
    }
    if ([self.txtBirthTime.text isEqualToString:@""]) {
        [self alertViewShow:@"Birth Time"];
        self.cmbCountry.text = @"";
        [self.txtBirthTime resignFirstResponder];
        [autoCompleteTextField setText:@""];
        return;
    }
    
    NSString* strCountry = [self.countrySource objectForKey:self.cmbCountry.text];

    NSString* strDate = self.txtBirtDate.text;
    NSString* strTime = self.txtBirthTime.text;
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *dbPath = [docsPath stringByAppendingPathComponent:@"natal.db"];
    
    const char *dbpath = [dbPath UTF8String];
    sqlite3_stmt    *statement;
    sqlite3 * mapDB;
    if (sqlite3_open(dbpath, &mapDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT A.id, A.latitude, A.longitude, B.stz , A.name, A.state FROM cities A INNER JOIN timezone B ON(A.country = B.country AND lower(A.maincity) = lower(B.city)) WHERE datetime('%@ %@') BETWEEN datetime(B.stime) AND datetime(B.etime) AND A.country = '%@' ORDER BY A.name, A.state", strDate, strTime, strCountry];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(mapDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
//            inUseDataSource = [NSMutableArray new];
            parentDataSource = [NSMutableArray new];
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *lat = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                NSString *lon = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                NSString *tz = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                NSString *name = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
                NSString *state = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)];
                NSString *cityName;
                if (![state isEqualToString:@""]) {
                    cityName = [NSString stringWithFormat:@"%@(%@)", name, state];
                }
                else{
                    cityName = name;
                }
                [parentDataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:lat, @"latitude", lon, @"longitude",tz, @"tz", cityName, @"cityname", nil]];
            }
            sqlite3_finalize(statement);
            
        }
        sqlite3_close(mapDB);
        if ([parentDataSource count] > 0) {
            inUseDataSource = [[NSArray alloc] initWithArray:parentDataSource ];
        }
        
    }
    [autoCompleteTextField setText:@""];
}
#pragma mark - NHAutoComplete DataSource delegate functions

- (NSInteger)autoCompleteTextBox:(NHAutoCompleteTextField *)autoCompleteTextBox numberOfRowsInSection:(NSInteger)section
{
    return [inUseDataSource count];
}

- (UITableViewCell *)autoCompleteTextBox:(NHAutoCompleteTextField *)autoCompleteTextBox cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [autoCompleteTextBox.suggestionListView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    // Create cell, you can use the most recent way to create a cell.
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
        [cell.textLabel setFont:[UIFont fontWithName:cell.textLabel.font.fontName size:13.5f]];
        [cell setHeight:15.0];
        //        [cell.detailTextLabel setFont:[UIFont fontWithName:cell.detailTextLabel.font.fontName size:11.0f]];
        
        [cell.textLabel setTextColor:[UIColor brownColor]];
        //        [cell.detailTextLabel setTextColor:[UIColor grayColor]];
        [cell setBackgroundColor:[UIColor textBoxColor]];
    }
    
    // Set text
    [cell.textLabel setText:[inUseDataSource[indexPath.row] objectForKey:@"cityname"]];
    //    [cell.detailTextLabel setText:[inUseDataSource[indexPath.row] objectForKey:@"Capital"]];
    // Clear previously highlighted text
//    [cell.textLabel normalizeSubstring:cell.textLabel.text];
    //    [cell.detailTextLabel normalizeSubstring:cell.detailTextLabel.text];
    
    // Highlight the selection
    if(autoCompleteTextBox.filterString)
    {
        [cell.textLabel boldSubstring:autoCompleteTextBox.filterString];
        //        [cell.detailTextLabel boldSubstring:autoCompleteTextBox.filterString];
    }
    
    return cell;
}

#pragma mark - NHAutoComplete Filter data source delegate functions

-(BOOL)shouldFilterDataSource:(NHAutoCompleteTextField *)autoCompleteTextBox
{
    return YES;
}

-(void)autoCompleteTextBox:(NHAutoCompleteTextField *)autoCompleteTextBox didFilterSourceUsingText:(NSString *)text
{
    if ([parentDataSource count] <  1)
    {
        return;
    }
    if ([text length] == 0)
    {
        inUseDataSource = [[NSArray alloc] initWithArray:parentDataSource ];
        return;
    }
    
    NSPredicate *predCountry = [NSPredicate predicateWithFormat:@"%K CONTAINS[cd] %@", @"cityname", text];
    
    NSArray *filteredArr = [[[NSArray alloc] initWithArray:parentDataSource ] filteredArrayUsingPredicate:predCountry];
    inUseDataSource = filteredArr;
}
-(void)autoCompleteTextBox:(NHAutoCompleteTextField *)autoCompleteTextBox selectRow:(NSInteger)selectedRow
{
    [self.txtLng setText:[self makeDegreeMMSS:[inUseDataSource[selectedRow] objectForKey:@"longitude"] withParam:false]];
    [self.txtLat setText:[self makeDegreeMMSS:[inUseDataSource[selectedRow] objectForKey:@"latitude"] withParam:true]];
    [self.txtTime setText:[inUseDataSource[selectedRow] objectForKey:@"tz"]];
}
-(void)clearParameter
{
    [self.txtLng setText:@""];
    [self.txtLat setText:@""];
    [self.txtTime setText:@""];
}

- (IBAction)clickSubmit:(id)sender {
    if ([self.txtUsername.text isEqualToString:@""]) {
        [self alertViewShow:@"User Name"];
        self.txtUsername.selected =TRUE;
        return;
    }
    
    if ([self.txtBirtDate.text isEqualToString:@""]) {
        [self alertViewShow:@"Birth Date"];
        [self.txtBirtDate resignFirstResponder];
        self.txtBirtDate.selected =TRUE;
        return;
    }
    if ([self.txtBirthTime.text isEqualToString:@""]) {
        [self alertViewShow:@"Birth Time"];
        [self.txtBirthTime resignFirstResponder];
        return;
    }
    if ([self.cmbCountry.text isEqualToString:@""]) {
        [self alertViewShow:@"Country"];
        self.cmbCountry.selected = TRUE;
        return;
    }
    
    if ([autoCompleteTextField.suggestionTextField.text isEqualToString:@""]) {
        [self alertViewShow:@"City Name"];
        [autoCompleteTextField.suggestionListView setHidden:TRUE];
        return;
    }
//    if ([self.txtEmail.text isEqualToString:@""] || ![self.txtEmail.text containsString:@"@"]) {
//        [self alertViewShow:@"Email Address"];
//        self.txtEmail.selected = TRUE;
//        return;
//    }
    
    NSArray *dateItems = [self.txtBirtDate.text componentsSeparatedByString:@"-"];
    NSArray *timeItems = [self.txtBirthTime.text componentsSeparatedByString:@":"];
    
    NSArray *latItems = [self.txtLat.text componentsSeparatedByString:@" "];
    int lat_min, lng_min;
//    if ([[latItems objectAtIndex:2] intValue] > 30) {
//        lat_min = [[latItems objectAtIndex:1] intValue] + 1;
//    }
    lat_min = [[latItems objectAtIndex:1] intValue];
    NSArray * lonItems = [self.txtLng.text componentsSeparatedByString:@" "];
//    if ([[lonItems objectAtIndex:2] intValue] > 30) {
//        lng_min = [[lonItems objectAtIndex:1] intValue] + 1;
//    }
    lng_min = [[lonItems objectAtIndex:1] intValue];
    NSString *mns;
    if ([[latItems objectAtIndex:3] isEqualToString:@"S"]){
         mns= @"-1";
    }
    else{
        mns = @"1";
    }
    NSString *mew;
    if ([[lonItems objectAtIndex:3] isEqualToString:@"W"]){
        mew= @"-1";
    }
    else{
        mew = @"1";
    }
    NSString *bithDay = [NSString stringWithFormat:@"%@ %@", self.txtBirtDate.text, self.txtBirthTime.text];
    NSString *check;
    if (self.checkBox.checked) {
        check = @"1";
    }
    else
    {
        check =@"0";
    }
//    NSString *strURl = [NSString stringWithFormat:@"http://beta.theclaregatetrust.org/NatalChart/page=natal&action=mobile&name=%@&fname=jin&lname=jin&year=%@&month=%@&day=%@&hour=%@&minute=%@&check=%@&timezone=%@&timezone1=UTC%@h&long_deg=%@&long_min=%@&ew=%@&lat_deg=%@&lat_min=%@&ns=%@&country=%@&counval=%@&city=%@&cityval=%@&birthday=%@&h_sys=P", self.txtUsername.text, [dateItems objectAtIndex:0], [dateItems objectAtIndex:1], [dateItems objectAtIndex:2],[timeItems objectAtIndex:0], [timeItems objectAtIndex:1],check, self.txtTime.text, self.txtTime.text, [lonItems objectAtIndex:0],[lonItems objectAtIndex:1], mew, [latItems objectAtIndex:0], [latItems objectAtIndex:1], mns, self.cmbCountry.text, self.cmbCountry.text, autoCompleteTextField.suggestionTextField.text, autoCompleteTextField.suggestionTextField.text, bithDay];
    NSString *strURl = [NSString stringWithFormat:@"page=natal&action=mobile&name=%@&fname=jin&lname=jin&year=%@&month=%@&day=%@&hour=%@&minute=%@&check=%@&timezone=%@&timezone1=UTC%@h&long_deg=%@&long_min=%i&ew=%@&lat_deg=%@&lat_min=%i&ns=%@&country=%@&counval=%@&city=%@&cityval=%@&birthday=%@&h_sys=P", self.txtUsername.text, [dateItems objectAtIndex:0], [dateItems objectAtIndex:1], [dateItems objectAtIndex:2],[timeItems objectAtIndex:0], [timeItems objectAtIndex:1],check, self.txtTime.text, self.txtTime.text, [lonItems objectAtIndex:0],lng_min, mew, [latItems objectAtIndex:0], lat_min, mns, self.cmbCountry.text, self.cmbCountry.text, autoCompleteTextField.suggestionTextField.text, autoCompleteTextField.suggestionTextField.text, bithDay];
    [self.mProgressView setHidden:FALSE];
    
    [self.mProgressView startAnimating];
    
    NSURL *aUrl = [NSURL URLWithString:@"http://192.168.0.209/NatalChart/"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:aUrl
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:30.0];
    
    
    [request setHTTPMethod:@"POST"];
    NSString *postString = strURl;
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    
    connection= [[NSURLConnection alloc] initWithRequest:request
                                                                 delegate:self];
    
    //////////////////////local net//////////////////////////////////
//    browser = [[NSNetServiceBrowser alloc] init];
//    browser.delegate = self;
//    [browser searchForServicesOfType:@"_daap._tcp" inDomain:nil];
}
- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data {
    NSLog (@"connectionDidReceiveData" );
    NSString *newText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (data != NULL) {
        NSError *jsonError=nil;
        NSDictionary *jsonResponse= [NSJSONSerialization JSONObjectWithData:data
                                                                    options:0 error:&jsonError];
        NSLog(@"jsonResponse:%@",jsonResponse);
        if(!jsonError && jsonResponse != nil){
            ChartViewController *chartViewController = [[ChartViewController alloc] initWithNibName: @"ChartViewController" bundle:nil];
            chartViewController.title = [NSString stringWithFormat: @"contents"];
            chartViewController.result = jsonResponse;
            [[self navigationController] pushViewController:chartViewController animated:YES];
        }
        else
        {
            UIAlertView *errorAlert = [[UIAlertView alloc]
                                       initWithTitle: @"Error"
                                       message: @"Invalid Parameter"
                                       delegate:nil
                                       cancelButtonTitle:@"OK"
                                       otherButtonTitles:nil];
            [errorAlert show];
            
        }
    
    }
    [self.mProgressView stopAnimating];
    [self.mProgressView setHidden:YES];
}
- (void) connectionDidFinishLoading: (NSURLConnection*)connection {
    [self.mProgressView stopAnimating];
    [self.mProgressView setHidden:YES];
}
-(void) connection:(NSURLConnection*)connection didFailWithError: (NSError*)error {
    UIAlertView *errorAlert = [[UIAlertView alloc]
                  initWithTitle: [error localizedDescription]
                  message: [error localizedFailureReason]
                  delegate:nil
                  cancelButtonTitle:@"OK"
                  otherButtonTitles:nil];
    [errorAlert show];
    [self.mProgressView stopAnimating];
    [self.mProgressView setHidden:YES];
}
-(NSString*) makeDegreeMMSS:(NSString*)degree withParam:(Boolean)isLat
{
    float deg = [degree floatValue];
//    if (deg<0) {
//        deg = deg * (-1);
//    }
    int int_deg = (int) deg;
    NSString* ns=[NSString new];
    if (int_deg < 0 ) {
        
        if (isLat)
        {
            ns = @"S";
//            mns = @"-1";
        }
        else {
//            mew = "-1";
            ns=@"W";
        }
    }
    else{
        if (isLat)
        {
            ns = @"N";
//            mns = "1";
        }
        else
        {
            ns = @"E";
//            mew = "1";
        }
    }
    
//    lat_deg = String.format("%d", Math.abs(int_deg));
    
    float min = (deg - int_deg) * 60;
    int lat_min = (int) min;
    int lat_sec = (int)((min - ((int) min)) * 60);
    return [NSString stringWithFormat:@"%i %i %i %@", [self absValue:int_deg], [self absValue:lat_min],[self absValue:lat_sec], ns];
}
-(int)absValue:(int)val
{
    if (val<0) {
        val = val * (-1);
    }
    return val;
}
@end
