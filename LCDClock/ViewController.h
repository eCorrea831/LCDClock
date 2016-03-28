//
//  ViewController.h
//  LCDClock
//
//  Created by Erica Correa on 3/21/16.
//  Copyright © 2016 Turn to Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Digit.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet Digit *digitOne;
@property (weak, nonatomic) IBOutlet Digit *digitTwo;
@property (weak, nonatomic) IBOutlet Digit *digitThree;
@property (weak, nonatomic) IBOutlet Digit *digitFour;
@property (weak, nonatomic) IBOutlet Digit *digitFive;
@property (weak, nonatomic) IBOutlet Digit *digitSix;
@property (weak, nonatomic) IBOutlet UIView *dotOne;
@property (weak, nonatomic) IBOutlet UIView *dotTwo;
@property (weak, nonatomic) IBOutlet UILabel *amPM;
@property (weak, nonatomic) IBOutlet UISwitch *militaryTimeSwitch;

@property (nonatomic) long digitOneNumber;
@property (nonatomic) long digitTwoNumber;
@property (nonatomic) long digitThreeNumber;
@property (nonatomic) long digitFourNumber;
@property (nonatomic) long digitFiveNumber;
@property (nonatomic) long digitSixNumber;


- (void)populateAllViews;
- (void)blinkDots;

@end

