//
//  Colors.m
//  LCDClock
//
//  Created by Erica Correa on 4/4/16.
//  Copyright © 2016 Turn to Tech. All rights reserved.
//

#import "Colors.h"

@implementation Colors

- (void)initWithRed:(float)red andGreen:(float)green andBlue:(float)blue andAlpha:(float)num  {
    [UIColor colorWithRed:red green:green blue:blue alpha:num];
}

+ (UIColor*) black {
    return [[UIColor alloc] initWithRed:0.00 green:0.00 blue:0.00 alpha:1.0];
}

+ (UIColor*) yellow {
    return [[UIColor alloc] initWithRed:0.90 green:0.89 blue:0.62 alpha:1.0];
}

+ (UIColor*) red {
    return [[UIColor alloc] initWithRed:0.84 green:0.13 blue:0.13 alpha:1.0];
}

+ (UIColor*) green {
    return [[UIColor alloc] initWithRed:0.58 green:0.77 blue:0.49 alpha:1.0];
}

+ (UIColor*) blue {
    return [[UIColor alloc] initWithRed:0.64 green:0.76 blue:0.96 alpha:1.0];
}

+ (UIColor*) purple {
    return [[UIColor alloc] initWithRed:0.56 green:0.49 blue:0.76 alpha:1.0];
}

+ (UIColor*) orange {
    return [[UIColor alloc] initWithRed:0.96 green:0.70 blue:0.42 alpha:1.0];
}

+ (NSArray*)backgroundColorArray {
    return @[[self black], [self yellow], [self red], [self green], [self blue], [self purple], [self orange]];
}

+ (NSArray*)colorArray {
    return @[[self red], [self green], [self blue], [self purple], [self orange],[self black], [self yellow],];
}

@end
