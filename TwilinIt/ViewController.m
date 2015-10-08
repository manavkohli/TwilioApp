//
//  ViewController.m
//  TwilinIt
//
//  Created by Manav Kohli on 10/7/15.
//  Copyright (c) 2015 Manav Kohli. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *twillButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Setup basic colors/layout
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.jpg"]]];
    [self.twillButton setBackgroundColor:[UIColor blueColor]];
    [self.twillButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.twillButton.titleLabel.font = [UIFont systemFontOfSize:24];
    self.twillButton.layer.cornerRadius = 10; // this value vary as per your desire
    self.twillButton.clipsToBounds = YES;
    self.titleLabel.layer.borderColor = [UIColor cyanColor].CGColor;
    
    
}
- (IBAction)buttonResponse:(id)sender {
    
    //Request header and body information
    NSString *twillSID =@"";
    NSString *twillSecret =@"";
    NSString *fromNumber = @"";
    NSString *toNumber = @"";
    NSString *message=@"Wow super sweet app you 'don got there.";
    
    // Build request
    NSString *urlString = [NSString stringWithFormat:@"https://%@:%@@api.twilio.com/2010-04-01/Accounts/%@/SMS/Messages", twillSID, twillSecret, twillSID];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    
    // Set up the body
    NSString *bodyString = [NSString stringWithFormat:@"From=%@&To=%@&Body=%@", fromNumber, toNumber, message];
    NSData *data = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    NSError *error;
    NSURLResponse *response;
    NSData *receivedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    // Handle the received data
    if (error) {
        NSLog(@"The Error Was: %@", error);
    } else {
        NSString *receivedString = [[NSString alloc]initWithData:receivedData encoding:NSUTF8StringEncoding];
        NSLog(@"Request sent. %@", receivedString);
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
