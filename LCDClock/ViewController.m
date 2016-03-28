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
    
    [self getCurrentTime];
    [self.digitOne showDigit:self.digitOneNumber];
    [self.digitTwo showDigit:self.digitTwoNumber];
    [self.digitThree showDigit:self.digitThreeNumber];
    [self.digitFour showDigit:self.digitFourNumber];
    [self.digitFive showDigit:self.digitFiveNumber];
    [self.digitSix showDigit:self.digitSixNumber];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)getCurrentTime {
    
    NSDate * now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm:ss"];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:now];
    
    if ([components hour] >= 10) {
        self.digitOneNumber = [components hour] / 10;
        self.digitTwoNumber = [components hour] % 10;
    } else {
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
}

@end
