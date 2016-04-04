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

//properties for visible elements on the main view
@property (weak, nonatomic) IBOutlet Digit *digitOne;
@property (weak, nonatomic) IBOutlet Digit *digitTwo;
@property (weak, nonatomic) IBOutlet Digit *digitThree;
@property (weak, nonatomic) IBOutlet Digit *digitFour;
@property (weak, nonatomic) IBOutlet Digit *digitFive;
@property (weak, nonatomic) IBOutlet Digit *digitSix;
@property (nonatomic) NSArray *digitArray;
@property (weak, nonatomic) IBOutlet UIView *dotOne;
@property (weak, nonatomic) IBOutlet UIView *dotTwo;
@property (weak, nonatomic) IBOutlet UILabel *amPM;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UILabel *militaryTimeLabel;
@property (weak, nonatomic) IBOutlet UISwitch *timeSwitch;

//properties for changing numbers to show current time
@property (nonatomic) long digitOneNumber;
@property (nonatomic) long digitTwoNumber;
@property (nonatomic) long digitThreeNumber;
@property (nonatomic) long digitFourNumber;
@property (nonatomic) long digitFiveNumber;
@property (nonatomic) long digitSixNumber;

//properties for changing the color of the text & background
@property (nonatomic, retain) UIColor *black;
@property (nonatomic, retain) UIColor *yellow;
@property (nonatomic, retain) UIColor *red;
@property (nonatomic, retain) UIColor *green;
@property (nonatomic, retain) UIColor *blue;
@property (nonatomic, retain) UIColor *purple;
@property (nonatomic, retain) UIColor *orange;
@property (nonatomic) NSArray *colorArray;

//properties for NSUserDefaults
@property (nonatomic) NSInteger theBackgroundColor;
@property (nonatomic) NSInteger theTextColor;
@property (nonatomic) NSInteger theTimeFormat;

//methods to show appropriate segments for each number and blink the dots

//- (IBAction)timeFormatSwitch:(id)sender;
- (void)populateAllViews;
- (void)blinkDots;
- (IBAction)changeTimeFormat:(id)sender;


//methods to change the text color and background color
- (void)initWithRed:(float) red andGreen:(float)green andBlue:(float)blue andAlpha:(float)num;
- (void)defineColors;
- (void)startGestureForBackground;
- (void)startGestureForText;
- (void)changeColor: (UIColor*)color;
- (void)useLongPressGestureForBackground: (UILongPressGestureRecognizer*) longPressGesture;
- (void)useSwipeLeftGestureForText: (UISwipeGestureRecognizer*) swipeGesture;
- (void)useSwipeRightGestureForText: (UISwipeGestureRecognizer*) swipeGesture;

//method for NSUserDefaults
- (void)updateNSUserDefaultsforKey:(NSString*)key;

@end

