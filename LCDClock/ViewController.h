//
//  ViewController.h
//  LCDClock
//
//  Created by Erica Correa on 3/21/16.
//  Copyright © 2016 Turn to Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Digit.h"
#import "Colors.h"

@interface ViewController : UIViewController

//properties for visible elements on the main view
@property (weak, nonatomic) IBOutlet Digit *digitOne;
@property (weak, nonatomic) IBOutlet Digit *digitTwo;
@property (weak, nonatomic) IBOutlet Digit *digitThree;
@property (weak, nonatomic) IBOutlet Digit *digitFour;
@property (weak, nonatomic) IBOutlet Digit *digitFive;
@property (weak, nonatomic) IBOutlet Digit *digitSix;
@property (nonatomic) NSMutableArray *digitArray;
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

//properties for NSUserDefaults
@property (nonatomic) NSInteger theBackgroundColor;
@property (nonatomic) NSInteger theTextColor;
@property (nonatomic) NSInteger theTimeFormat;

//properties for plist
@property (nonatomic) NSNumber *userBackgroundColor;
@property (nonatomic) NSNumber *userTextColor;
@property (nonatomic) NSNumber *userTimeFormat;

//methods to show appropriate segments for each number and blink the dots
- (void)populateAllViews;
- (void)blinkDots;
- (IBAction)changeTimeFormat:(id)sender;

//methods to change the text color and background color
- (void)startGestureForBackground;
- (void)startGestureForText;
- (void)changeColor: (UIColor*)color;
- (int)getIndexColorForText;
- (int)getIndexColorForBackground;
- (void)useLongPressGestureForBackground: (UILongPressGestureRecognizer*) longPressGesture;
- (void)useSwipeLeftGestureForText: (UISwipeGestureRecognizer*) swipeGesture;
- (void)useSwipeRightGestureForText: (UISwipeGestureRecognizer*) swipeGesture;

//method for NSUserDefaults
- (void)updateNSUserDefaultsforKey:(NSString*)key;

@end

