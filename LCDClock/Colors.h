//
//  Colors.h
//  LCDClock
//
//  Created by Erica Correa on 4/4/16.
//  Copyright © 2016 Turn to Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Colors : UIView

- (void)initWithRed:(float)red andGreen:(float)green andBlue:(float)blue andAlpha:(float)num;
+ (UIColor*)black;
+ (UIColor*)yellow;
+ (UIColor*)red;
+ (UIColor*)green;
+ (UIColor*)blue;
+ (UIColor*)purple;
+ (UIColor*)orange;
+ (NSArray*)colorArray;


@end
