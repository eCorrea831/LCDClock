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

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self populateAllViews];
    
    [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(blinkDots) userInfo:nil repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(populateAllViews) userInfo:nil repeats:YES];
    
    [self setColors];
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
    self.amPM.hidden = NO;
    
    if ([components hour] > 11) {
        self.amPM.text = @"PM";
    } else {
        self.amPM.text = @"AM";
    }
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

//set colors for tap method
- (void)setColors {
    self.black = [[UIColor alloc] init];
    self.black = [UIColor blackColor];
    self.yellow = [[UIColor alloc] init];
    self.yellow = [UIColor colorWithRed:0.90 green:0.89 blue:0.62 alpha:1.0];
    self.red = [[UIColor alloc] init];
    self.red = [UIColor colorWithRed:0.84 green:0.13 blue:0.13 alpha:1.0];
    self.green = [[UIColor alloc] init];
    self.green = [UIColor colorWithRed:0.58 green:0.77 blue:0.49 alpha:1.0];
    self.blue = [[UIColor alloc] init];
    self.blue = [UIColor colorWithRed:0.64 green:0.76 blue:0.96 alpha:1.0];
    self.purple = [[UIColor alloc] init];
    self.purple = [UIColor colorWithRed:0.56 green:0.49 blue:0.76 alpha:1.0];
    self.orange = [[UIColor alloc] init];
    self.orange = [UIColor colorWithRed:0.96 green:0.70 blue:0.42 alpha:1.0];
}

- (void)changeColor: (UIColor *)color {
    [self.militaryTimeLabel setTextColor:color];
    [self.amPM setTextColor:color];
    [self.dotOne setBackgroundColor:color];
    [self.dotTwo setBackgroundColor:color];
  
    for (Digit *digit in self.digitArray) {
        [digit.segmentOne setBackgroundColor:color];
        [digit.segmentTwo setBackgroundColor:color];
        [digit.segmentThree setBackgroundColor:color];
        [digit.segmentFour setBackgroundColor:color];
        [digit.segmentFive setBackgroundColor:color];
        [digit.segmentSix setBackgroundColor:color];
        [digit.segmentSeven setBackgroundColor:color];
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
    
    //get instance of long press gesture and add to mainView
    UISwipeGestureRecognizer *swipeText = [[UISwipeGestureRecognizer alloc] initWithTarget: self action: @selector(useSwipeGestureForText:)];
    [self.mainView addGestureRecognizer:swipeText];
}

- (void)useLongPressGestureForBackground: (UILongPressGestureRecognizer*) longPressGesture {
    if (longPressGesture.state == UIGestureRecognizerStateBegan) {
        if ([self.mainView.backgroundColor isEqual: self.black]) {
            [self.mainView setBackgroundColor:self.yellow];
        } else if ([self.mainView.backgroundColor isEqual:self.yellow]) {
            [self.mainView setBackgroundColor:self.red];
        } else if ([self.mainView.backgroundColor isEqual:self.red]) {
            [self.mainView setBackgroundColor:self.green];
        } else if ([self.mainView.backgroundColor isEqual:self.green]) {
            [self.mainView setBackgroundColor:self.blue];
        } else if ([self.mainView.backgroundColor isEqual:self.blue]) {
            [self.mainView setBackgroundColor:self.purple];
        } else if ([self.mainView.backgroundColor isEqual:self.purple]) {
            [self.mainView setBackgroundColor:self.orange];
        } else {
            [self.mainView setBackgroundColor:self.black];
        }
    }
}

- (void)useSwipeGestureForText: (UISwipeGestureRecognizer*) swipeGesture {
    [UIView animateWithDuration:0.5 animations:^{
        if ([self.militaryTimeLabel.textColor isEqual:self.red]) {
            [self changeColor:self.green];
        } else if ([self.militaryTimeLabel.textColor isEqual:self.green]){
            [self changeColor:self.blue];
        } else if ([self.militaryTimeLabel.textColor isEqual:self.blue]){
            [self changeColor:self.purple];
        } else if ([self.militaryTimeLabel.textColor isEqual:self.purple]){
            [self changeColor:self.orange];
        } else if ([self.militaryTimeLabel.textColor isEqual:self.orange]){
            [self changeColor:self.black];
        } else if ([self.militaryTimeLabel.textColor isEqual:self.black]){
            [self changeColor:self.yellow];
        } else {
            [self changeColor:self.red];        }
    }];

}

@end
