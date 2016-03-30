//
//  ViewController.m
//  LCDClock
//
//  Created by Erica Correa on 3/21/16.
//  Copyright © 2016 Turn to Tech. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

//TODO: add logic so text color != background color
//TODO: implement NSUserDefaults
//TODO: implement a secondary archiving system

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self populateAllViews];
    
    [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(blinkDots) userInfo:nil repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(populateAllViews) userInfo:nil repeats:YES];
    
    [self defineColors];
    self.digitArray = @[self.digitOne, self.digitTwo, self.digitThree, self.digitFour, self.digitFive, self.digitSix];
    [self startGestureForBackground];
    [self startGestureForText];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)getCurrentStandardTime {
    
    NSDate * now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm:ss a"];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:now];
    
    if ([components hour] - 12 >= 10) {
        self.digitOne.hidden = NO;
        self.digitOneNumber = ([components hour] - 12) / 10;
        self.digitTwoNumber = ([components hour] - 12) % 10;
    } else {
        self.digitOne.hidden = YES;
        self.digitTwoNumber = ([components hour] - 12);
    }
    if ([components minute] >= 10) {
        self.digitThreeNumber = [components minute] / 10;
        self.digitFourNumber = [components minute] % 10;
    } else {
        self.digitThreeNumber = 0;
        self.digitFourNumber = [components minute];
    }
    if ([components second] >= 10) {
        self.digitFiveNumber = [components second] / 10;
        self.digitSixNumber = [components second] % 10;
    } else {
        self.digitFiveNumber = 0;
        self.digitSixNumber = [components second];
    }
    if ([components hour] > 11) {
        self.amPM.text = @"PM";
    } else {
        self.amPM.text = @"AM";
    }
    self.amPM.hidden = NO;
}

- (void)getCurrentMilitaryTime {
    
    NSDate * now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm:ss a"];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:now];
    
    if ([components hour] >= 10) {
        self.digitOne.hidden = NO;
        self.digitOneNumber = [components hour] / 10;
        self.digitTwoNumber = [components hour] % 10;
    } else {
        self.digitOne.hidden = NO;
        self.digitOneNumber = 0;
        self.digitTwoNumber = [components hour];
    }
    if ([components minute] >= 10) {
        self.digitThreeNumber = [components minute] / 10;
        self.digitFourNumber = [components minute] % 10;
    } else {
        self.digitThreeNumber = 0;
        self.digitFourNumber = [components minute];
    }
    if ([components second] >= 10) {
        self.digitFiveNumber = [components second] / 10;
        self.digitSixNumber = [components second] % 10;
    } else {
        self.digitFiveNumber = 0;
        self.digitSixNumber = [components second];
    }
    self.amPM.hidden = YES;
}

- (void)populateAllViews {
    [self.digitOne showDigit:self.digitOneNumber];
    [self.digitTwo showDigit:self.digitTwoNumber];
    [self.digitThree showDigit:self.digitThreeNumber];
    [self.digitFour showDigit:self.digitFourNumber];
    [self.digitFive showDigit:self.digitFiveNumber];
    [self.digitSix showDigit:self.digitSixNumber];
    self.dotOne.hidden = NO;
    self.dotTwo.hidden = NO;
    if ([self.militaryTimeSwitch isOn]) {
        [self getCurrentMilitaryTime];
    } else {
        [self getCurrentStandardTime];
    }
}

- (void)blinkDots {
    self.dotOne.hidden = YES;
    self.dotTwo.hidden = YES;
}

- (void)initWithRed:(float)red andGreen:(float)green andBlue:(float)blue andAlpha:(float)num  {
    [UIColor colorWithRed:red green:green blue:blue alpha:num];
}

//set colors for tap method
- (void)defineColors {
    self.black = [[UIColor alloc] initWithRed:0.00 green:0.00 blue:0.00 alpha:1.0];
    self.yellow = [[UIColor alloc] initWithRed:0.90 green:0.89 blue:0.62 alpha:1.0];
    self.red = [[UIColor alloc] initWithRed:0.84 green:0.13 blue:0.13 alpha:1.0];
    self.green = [[UIColor alloc] initWithRed:0.58 green:0.77 blue:0.49 alpha:1.0];
    self.blue = [[UIColor alloc] initWithRed:0.64 green:0.76 blue:0.96 alpha:1.0];
    self.purple = [[UIColor alloc] initWithRed:0.56 green:0.49 blue:0.76 alpha:1.0];
    self.orange = [[UIColor alloc] initWithRed:0.96 green:0.70 blue:0.42 alpha:1.0];
    
    self.colorArray = @[self.black, self.yellow, self.red, self.green, self.blue, self.purple, self.orange];
}

- (void)changeColor: (UIColor *)color {
    [self.militaryTimeLabel setTextColor:color];
    [self.amPM setTextColor:color];
    [self.dotOne setBackgroundColor:color];
    [self.dotTwo setBackgroundColor:color];
  
    for (Digit *digit in self.digitArray) {
        for (UIView *segment in digit.segmentArray) {
            segment.backgroundColor = color;
        }
    }
}

- (void)startGestureForBackground {

    //set initial color
    [self.mainView setBackgroundColor:self.black];
    
    //get instance of long press gesture and add to mainView
    UILongPressGestureRecognizer *longPressBackground = [[UILongPressGestureRecognizer alloc] initWithTarget: self action: @selector(useLongPressGestureForBackground:)];
    [self.mainView addGestureRecognizer:longPressBackground];
}

- (void)startGestureForText {
    
    //set initial color
    [self changeColor:self.red];
    
    //get instance of swipeLeft gesture and add to mainView
    UISwipeGestureRecognizer *swipeTextLeft = [[UISwipeGestureRecognizer alloc] initWithTarget: self action: @selector(useSwipeLeftGestureForText:)];
    swipeTextLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.mainView addGestureRecognizer:swipeTextLeft];
    
    //get instance of swipeRight gesture and add to mainView
    UISwipeGestureRecognizer *swipeTextRight = [[UISwipeGestureRecognizer alloc] initWithTarget: self action: @selector(useSwipeRightGestureForText:)];
    swipeTextRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.mainView addGestureRecognizer:swipeTextRight];
}

- (void)useLongPressGestureForBackground: (UILongPressGestureRecognizer*) longPressGesture {
    if (longPressGesture.state == UIGestureRecognizerStateBegan) {
        
        int colorIndex = 0;
        for (int index = 0; index <= [self.colorArray count] - 1; index++) {
            if ([self.colorArray[index] isEqual:self.mainView.backgroundColor]) {
                colorIndex = index;
            }
        }
        if ([self.mainView.backgroundColor isEqual:self.colorArray[6]]) {
            [self.mainView setBackgroundColor:self.colorArray[0]];
        } else {
            colorIndex++;
            [self.mainView setBackgroundColor:self.colorArray[colorIndex]];
        }
    }
}

- (void)useSwipeLeftGestureForText: (UISwipeGestureRecognizer*) swipeGesture {
    [UIView animateWithDuration:0.5 animations:^{
        
        int colorIndex = 0;
        for (int index = 0; index <= [self.colorArray count] - 1; index++) {
            if ([self.colorArray[index] isEqual:self.militaryTimeLabel.textColor]) {
                colorIndex = index;
            }
        }
        if ([self.militaryTimeLabel.textColor isEqual:self.colorArray[6]]) {
            [self changeColor:self.colorArray[0]];
        } else {
            colorIndex++;
            [self changeColor:self.colorArray[colorIndex]];
        }
    }];
}

- (void)useSwipeRightGestureForText: (UISwipeGestureRecognizer*) swipeGesture {
    [UIView animateWithDuration:0.5 animations:^{
        
        int colorIndex = 0;
        for (int index = 0; index <= [self.colorArray count] - 1; index++) {
            if ([self.colorArray[index] isEqual:self.militaryTimeLabel.textColor]) {
                colorIndex = index;
            }
        }
        if ([self.militaryTimeLabel.textColor isEqual:self.colorArray[0]]) {
            [self changeColor:self.colorArray[6]];
        } else {
            colorIndex--;
            [self changeColor:self.colorArray[colorIndex]];
        }
    }];
}

@end
