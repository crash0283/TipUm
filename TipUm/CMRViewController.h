//
//  CMRViewController.h
//  TipUm
//
//  Created by Chris Rasch on 8/15/14.
//  Copyright (c) 2014 __Flip Flop Studios__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface CMRViewController : UIViewController <UIAlertViewDelegate,ADBannerViewDelegate>

@property (nonatomic)float fifteen;
@property (nonatomic)float eighteen;
@property (nonatomic)float twenty;
@property (nonatomic)IBOutlet UITextField *textField;
@property (nonatomic)NSString *subTotalAmount;
@property (nonatomic,weak)IBOutlet UILabel *taxAmount;
@property (nonatomic,weak)IBOutlet UILabel *grandTotal;
@property (nonatomic)UIAlertView *customAlert;
@property (nonatomic)UITextField *customText;

@end
