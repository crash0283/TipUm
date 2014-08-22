//
//  CMRViewController.m
//  TipUm
//
//  Created by Chris Rasch on 8/15/14.
//  Copyright (c) 2014 __Flip Flop Studios__. All rights reserved.
//

#import "CMRViewController.h"

@interface CMRViewController () <UITextFieldDelegate>


@end

@implementation CMRViewController {
    
    BOOL _bannerIsVisible;
    ADBannerView *_adBanner;
}


-(IBAction)fifteenPercentTax:(id)sender
{
    //NSLog(@"I'm fifteen!");
    self.fifteen = [self.subTotalAmount floatValue] * 0.15;
    NSString *fifteenPercentTotal = [NSString stringWithFormat:@"$%.2f",self.fifteen];
    float totalWithTip = self.fifteen + [self.subTotalAmount floatValue];
    NSString *grandTotalFifteen = [NSString stringWithFormat:@"$%.2f",totalWithTip];
    if (self.subTotalAmount.length > 0) {
        self.taxAmount.text = fifteenPercentTotal;
        self.grandTotal.text = grandTotalFifteen;
    }
    else {
        UIAlertView *invalidAlert = [[UIAlertView alloc] initWithTitle:@"Invalid Entry!" message:@"Please Enter Sub Total" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [invalidAlert show];
        
    }
}

-(IBAction)eighteenPercentTax:(id)sender
{
    //NSLog(@"I'm eighteen!");
    self.eighteen = [self.subTotalAmount floatValue] * 0.18;
    NSString *eighteenPercentTotal = [NSString stringWithFormat:@"$%.2f",self.eighteen];
    float totalWithTip = self.eighteen + [self.subTotalAmount floatValue];
    NSString *grandTotalEighteen = [NSString stringWithFormat:@"$%.2f",totalWithTip];
    if (self.subTotalAmount.length > 0) {
        self.taxAmount.text = eighteenPercentTotal;
        self.grandTotal.text = grandTotalEighteen;
        
    }
    else {
        UIAlertView *invalidAlert = [[UIAlertView alloc] initWithTitle:@"Invalid Entry!" message:@"Please Enter Sub Total" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [invalidAlert show];
        
    }
}

-(IBAction)twentyPercent:(id)sender
{
    //NSLog(@"I'm twenty!");
    self.twenty = [self.subTotalAmount floatValue] * 0.20;
    NSString *twentyPercentTotal = [NSString stringWithFormat:@"$%.2f",self.twenty];
    float totalWithTip = self.twenty + [self.subTotalAmount floatValue];
    NSString *grandTotalTwenty = [NSString stringWithFormat:@"$%.2f", totalWithTip];
    if (self.subTotalAmount.length > 0) {
        self.taxAmount.text = twentyPercentTotal;
        self.grandTotal.text = grandTotalTwenty;
        
    }
    else {
        UIAlertView *invalidAlert = [[UIAlertView alloc] initWithTitle:@"Invalid Entry!" message:@"Please Enter Sub Total" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [invalidAlert show];
        
    }
    
    
}

-(IBAction)custom:(id)sender
{
    if (self.subTotalAmount.length > 0) {
        self.customAlert = [[UIAlertView alloc ] initWithTitle:@"Feeling Generous?" message:@"Please Enter Tip Percentage" delegate:self cancelButtonTitle:@"Done" otherButtonTitles:@"Cancel", nil];
        self.customAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [self.customAlert show];
        
        self.customText = [self.customAlert textFieldAtIndex:0];
        self.customText.placeholder = @"Tip %";
        self.customText.keyboardType = UIKeyboardTypeDecimalPad;
        
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Invalid Entry!" message:@"Please Enter Sub Total" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
        
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.customText.text.length > 0) {
        if (buttonIndex == [self.customAlert cancelButtonIndex]) {
            NSString *alertTip = self.customText.text;
            float customPercent = [alertTip floatValue] * 0.01;
            //NSLog(@"%.2f",customPercent);
            float customTipTotal = [self.subTotalAmount floatValue] * customPercent;
            //NSLog(@"%.2f",customTipTotal);
            NSString *customTipViewTotal = [NSString stringWithFormat:@"$%.2f",customTipTotal];
            float customGrandTotal = [self.subTotalAmount floatValue] + customTipTotal;
            NSString *customViewGrandTotal = [NSString stringWithFormat:@"$%.2f",customGrandTotal];
            self.grandTotal.text = customViewGrandTotal;
            self.taxAmount.text = customTipViewTotal;
        }
        
    }
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:
                                   [UIImage imageNamed:@"redWine.jpg"]];
    backgroundView.frame = self.view.frame;
    [self.view addSubview:backgroundView];
    [self.view sendSubviewToBack:backgroundView];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _adBanner = [[ADBannerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, 320, 50)];
    _adBanner.delegate = self;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField

{
    
    self.subTotalAmount = textField.text;
    [textField resignFirstResponder];
    
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!_bannerIsVisible)
    {
        // If banner isn't part of view hierarchy, add it
        if (_adBanner.superview == nil)
        {
            [self.view addSubview:_adBanner];
        }
        
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        
        // Assumes the banner view is just off the bottom of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, -banner.frame.size.height);
        
        [UIView commitAnimations];
        
        _bannerIsVisible = YES;
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    //NSLog(@"Failed to retrieve ad");
    
    if (_bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        
        // Assumes the banner view is placed at the bottom of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, banner.frame.size.height);
        
        [UIView commitAnimations];
        
        _bannerIsVisible = NO;
    }
}


@end
