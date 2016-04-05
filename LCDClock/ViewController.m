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
    
    //assigns defaults for archiving
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.theBackgroundColor = [defaults integerForKey:@"defaultBackgroundColor"];
    self.theTextColor = [defaults integerForKey:@"defaultTextColor"];
    self.theTimeFormat = [defaults integerForKey:@"defaultTimeFormat"];
    
    //loads data from plist into view
    [self loadData];

    //sets time format to standard time if it's the first time opening, and default after
    if (self.theTimeFormat == 0){
        [self getCurrentStandardTime];
        [self.timeSwitch setOn:NO animated:YES];
    } else {
        [self getCurrentMilitaryTime];
        [self.timeSwitch setOn:YES animated:YES];
    }
    
    //gets segments and label showing according to time format
    [self populateAllViews];

    //timers to change segments to display current time each second and blink the dots
    [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(blinkDots) userInfo:nil repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(populateAllViews) userInfo:nil repeats:YES];
    
    //sets colors and array that will be used for gesture methods and sets gesture methods
    self.digitArray = [[NSMutableArray alloc] initWithArray:@[self.digitOne, self.digitTwo, self.digitThree, self.digitFour, self.digitFive, self.digitSix]];
    [self setInitialBackgroundColor];
    [self setInitialTextColor];
    [self startGestureForBackground];
    [self startGestureForText];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//updates defaults for archiving
- (void)updateNSUserDefaultsforKey:(NSString*)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([key isEqualToString:@"defaultBackgroundColor"]) {
        [defaults setInteger:[self getIndexColorForBackground] forKey:@"defaultBackgroundColor"];
    } else if ([key isEqualToString:@"defaultTextColor"]) {
        [defaults setInteger:[self getIndexColorForText] forKey:@"defaultTextColor"];
    } else if ([key isEqualToString:@"defaultTimeFormat"]) {
        [defaults setInteger:[self getTimeFormat] forKey:@"defaultTimeFormat"];
    }
    [defaults synchronize];
}

//creates plist for secondary archiving system
- (NSString *)getFilePath {
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[pathArray objectAtIndex:0] stringByAppendingPathComponent:@"settings.plist"];
}

//saves data to plist
- (void)saveData {
    
    NSArray *value = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:[self getIndexColorForBackground]],[NSNumber numberWithInt:[self getIndexColorForText]], [NSNumber numberWithInt:[self getTimeFormat]], nil];
    
    [value writeToFile:[self getFilePath] atomically:YES];
}

- (void)loadData {
    NSString *myPath = [self getFilePath];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:myPath];
    
    if (fileExists) {
        NSArray *values = [[NSArray alloc] initWithContentsOfFile:myPath];
        
        self.userBackgroundColor = [values objectAtIndex:0];
        self.userTextColor = [values objectAtIndex:1];
        self.userTimeFormat = [values objectAtIndex:2];
    }
}

//gets the index of the background color from the array for use with gesture methods
- (int)getIndexColorForBackground {
    int backgroundColorIndex = 0;
    for (int index = 0; index <= [[Colors colorArray] count] - 1; index++) {
        if ([[Colors colorArray][index] isEqual:self.mainView.backgroundColor]) {
            backgroundColorIndex = index;
        }
    }
    return backgroundColorIndex;
}

//sets initial background color
- (void)setInitialBackgroundColor {
    if (self.theBackgroundColor == 0) {
        [self.mainView setBackgroundColor:[Colors black]];
        [self updateNSUserDefaultsforKey:@"defaultBackgroundColor"];
        [self saveData];
    }
    else {
        [self.mainView setBackgroundColor:[Colors colorArray][self.theBackgroundColor]];
    }
}

//gets the index of the text color from the array for use with gesture methods
- (int)getIndexColorForText {
    int textColorIndex = 0;
    for (int index = 0; index <= [[Colors colorArray] count] - 1; index++) {
        if ([[Colors colorArray][index] isEqual:self.militaryTimeLabel.textColor]) {
            textColorIndex = index;
        }
    }
    return textColorIndex;
}

//sets initial text color
- (void)setInitialTextColor {
    [self changeColor:[Colors colorArray][self.theTextColor]];
    if (self.theTextColor == self.theBackgroundColor) {
        [self changeColor:[Colors red]];
    }
}

//changes colors for gesture methods
- (void)changeColor: (UIColor*)color {
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

- (int)getTimeFormat {
    if (self.amPM.hidden == YES) {
        return 1; //militaryTimeFormat
    } else {
        return 0; //standardTimeFormat
    }
}

//displays time in standard time format
- (void)getCurrentStandardTime {
    
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm:ss a"];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:now];
    
    self.amPM.hidden = NO;
    
    if ([components hour] > 11) {
        self.amPM.text = @"PM";
    } else {
        self.amPM.text = @"AM";
    }
    
    if ([self.amPM.text isEqualToString:@"AM"]) {
        if ([components hour] >= 10) {
            self.digitOne.hidden = NO;
            self.digitOneNumber = [components hour] / 10;
            self.digitTwoNumber = [components hour] % 10;
        } else {
            self.digitOne.hidden = YES;
            self.digitTwoNumber = [components hour];
        }
    } else {
        if ([components hour] - 12 >= 10) {
            self.digitOne.hidden = NO;
            self.digitOneNumber = ([components hour] - 12) / 10;
            self.digitTwoNumber = ([components hour] - 12) % 10;
        } else {
            if ([components hour] == 11 || [components hour] == 12) {
                self.digitOne.hidden = NO;
                self.digitOneNumber = [components hour] / 10;
                self.digitTwoNumber = [components hour] % 10;
            } else {
                self.digitOne.hidden = YES;
                self.digitTwoNumber = ([components hour] - 12);
            }
        }
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

//displays time in military time format
- (void)getCurrentMilitaryTime {
    
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm:ss a"];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:now];
    
    if ([components hour] >= 10) {
        self.digitOne.hidden = NO;
        self.digitOneNumber = [components hour] / 10;
        self.digitTwoNumber = [components hour] % 10;
        
    } else {
        self.digitOne.hidden = YES;
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

//defines action for switch
- (IBAction)changeTimeFormat:(id)sender {
    if ([sender isOn]) {
        [self getCurrentMilitaryTime];
    } else {
        [self getCurrentStandardTime];
    }
    [self updateNSUserDefaultsforKey:@"defaultTimeFormat"];
    [self saveData];
}

- (void)populateAllViews {
    
    long digitNumberArray[] = {self.digitOneNumber, self.digitTwoNumber, self.digitThreeNumber, self.digitFourNumber, self.digitFiveNumber, self.digitSixNumber};
    for (int index = 0; index < 6; index++) {
        [self.digitArray[index] showDigit:digitNumberArray[index]];
    }
    
    self.dotOne.hidden = NO;
    self.dotTwo.hidden = NO;
    
    if ([self.timeSwitch isOn]){
        [self getCurrentMilitaryTime];
        [self.timeSwitch setOn:YES animated:YES];
    } else {
        [self getCurrentStandardTime];
        [self.timeSwitch setOn:NO animated:YES];
    }
}

- (void)blinkDots {
    self.dotOne.hidden = YES;
    self.dotTwo.hidden = YES;
}

- (void)startGestureForBackground {
    //gets instance of long press gesture and adds to mainView
    UILongPressGestureRecognizer *longPressBackground = [[UILongPressGestureRecognizer alloc] initWithTarget: self action: @selector(useLongPressGestureForBackground:)];
    [self.mainView addGestureRecognizer:longPressBackground];
}

- (void)useLongPressGestureForBackground: (UILongPressGestureRecognizer*) longPressGesture {
    if (longPressGesture.state == UIGestureRecognizerStateBegan) {
        
        int backgroundColorIndex = [self getIndexColorForBackground];
        int textColorIndex = [self getIndexColorForText];
        
        if ([self.mainView.backgroundColor isEqual:[Colors colorArray][6]]) {
            if (textColorIndex == 0) {
                [self.mainView setBackgroundColor:[Colors colorArray][1]];
            } else {
                [self.mainView setBackgroundColor:[Colors colorArray][0]];
            }
        } else {
            backgroundColorIndex++;
            if (backgroundColorIndex == textColorIndex) {
                backgroundColorIndex++;
                [self.mainView setBackgroundColor:[Colors colorArray][backgroundColorIndex]];
            } else {
                [self.mainView setBackgroundColor:[Colors colorArray][backgroundColorIndex]];
            }
        }
    }
    [self updateNSUserDefaultsforKey:@"defaultBackgroundColor"];
    [self saveData];
}

- (void)startGestureForText {
    
    //gets instance of swipeLeft gesture and adds to mainView
    UISwipeGestureRecognizer *swipeTextLeft = [[UISwipeGestureRecognizer alloc] initWithTarget: self action: @selector(useSwipeLeftGestureForText:)];
    swipeTextLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.mainView addGestureRecognizer:swipeTextLeft];
    
    //gets instance of swipeRight gesture and adds to mainView
    UISwipeGestureRecognizer *swipeTextRight = [[UISwipeGestureRecognizer alloc] initWithTarget: self action: @selector(useSwipeRightGestureForText:)];
    swipeTextRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.mainView addGestureRecognizer:swipeTextRight];
}

- (void)useSwipeLeftGestureForText: (UISwipeGestureRecognizer*) swipeGesture {
    [UIView animateWithDuration:0.5 animations:^{
        
        int backgroundColorIndex = [self getIndexColorForBackground];
        int textColorIndex = [self getIndexColorForText];
        
        if ([self.militaryTimeLabel.textColor isEqual:[Colors colorArray][6]]) {
            if (backgroundColorIndex == 0) {
                [self changeColor:[Colors colorArray][1]];
            } else {
                [self changeColor:[Colors colorArray][0]];
            }
        } else {
            textColorIndex++;
            if (textColorIndex == backgroundColorIndex) {
                if (textColorIndex == 6) {
                    textColorIndex = 0;
                } else {
                    textColorIndex++;
                }
                [self changeColor:[Colors colorArray][textColorIndex]];
            } else {
                [self changeColor:[Colors colorArray][textColorIndex]];
            }
        }
    }];
    [self updateNSUserDefaultsforKey:@"defaultTextColor"];
    [self saveData];
}

- (void)useSwipeRightGestureForText: (UISwipeGestureRecognizer*) swipeGesture {
    [UIView animateWithDuration:0.5 animations:^{
        
        int backgroundColorIndex = [self getIndexColorForBackground];
        int textColorIndex = [self getIndexColorForText];
        
        if ([self.militaryTimeLabel.textColor isEqual:[Colors colorArray][0]]) {
            if (backgroundColorIndex == 6) {
                [self changeColor:[Colors colorArray][5]];
            } else {
                [self changeColor:[Colors colorArray][6]];
            }
        } else {
            textColorIndex--;
            if (textColorIndex == backgroundColorIndex) {
                if (textColorIndex == 0) {
                    textColorIndex = 6;
                } else {
                    textColorIndex--;
                }
                [self changeColor:[Colors colorArray][textColorIndex]];
            } else {
                [self changeColor:[Colors colorArray][textColorIndex]];
            }
        }
    }];
    [self updateNSUserDefaultsforKey:@"defaultTextColor"];
    [self saveData];
}

@end
