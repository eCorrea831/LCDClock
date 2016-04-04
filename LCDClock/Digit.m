//
//  Digit.m
//  LCDClock
//
//  Created by Erica Correa on 3/21/16.
//  Copyright © 2016 Turn to Tech. All rights reserved.
//

#import "Digit.h"

@implementation Digit

-(id)initWithCoder:(NSCoder *)aDecoder {
    
    if ((self = [super initWithCoder:aDecoder])) {
        UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"Digit" owner:self options:nil] objectAtIndex:0];
        
        view.frame = self.bounds;
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:view];
        [self createSegementArray];
    }

    return self;
}

- (void)createSegementArray {
    self.segmentArray = @[self.segmentOne, self.segmentTwo, self.segmentThree, self.segmentFour, self.segmentFive, self.segmentSix, self.segmentSeven];
}

- (void)showDigit:(long)number {
    
    switch ((long) number) {
        case 0:
            for (int segment = 0; segment <= 4; segment++) {
                UIView *thisSegment = self.segmentArray[segment];
                thisSegment.hidden = NO;
            }
            self.segmentSix.hidden = YES;
            self.segmentSeven.hidden = NO;
            break;
        case 1:
            self.segmentOne.hidden = YES;
            self.segmentTwo.hidden = NO;
            self.segmentThree.hidden = YES;
            self.segmentFour.hidden = NO;
            for (int segment = 4; segment <=6; segment++) {
                UIView *thisSegment = self.segmentArray[segment];
                thisSegment.hidden = YES;
            }
            break;
        case 2:
            self.segmentOne.hidden = YES;
            self.segmentTwo.hidden = NO;
            self.segmentThree.hidden = NO;
            self.segmentFour.hidden = YES;
            for (int segment = 4; segment <=6; segment++) {
                UIView *thisSegment = self.segmentArray[segment];
                thisSegment.hidden = NO;
            }
            break;
        case 3:
            self.segmentOne.hidden = YES;
            self.segmentTwo.hidden = NO;
            self.segmentThree.hidden = YES;
            
            for (int segment = 3; segment <=6; segment++) {
                UIView *thisSegment = self.segmentArray[segment];
                thisSegment.hidden = NO;
            }
            break;
        case 4:
            self.segmentOne.hidden = NO;
            self.segmentTwo.hidden = NO;
            self.segmentThree.hidden = YES;
            self.segmentFour.hidden = NO;
            self.segmentFive.hidden = YES;
            self.segmentSix.hidden = NO;
            self.segmentSeven.hidden = YES;
            break;
        case 5:
            self.segmentOne.hidden = NO;
            self.segmentTwo.hidden = YES;
            self.segmentThree.hidden = YES;
            for (int segment = 3; segment <=6; segment++) {
                UIView *thisSegment = self.segmentArray[segment];
                thisSegment.hidden = NO;
            }
            break;
        case 6:
            self.segmentOne.hidden = NO;
            self.segmentTwo.hidden = YES;
            for (int segment = 2; segment <=6; segment++) {
                UIView *thisSegment = self.segmentArray[segment];
                thisSegment.hidden = NO;
            }
            break;
        case 7:
            self.segmentOne.hidden = YES;
            self.segmentTwo.hidden = NO;
            self.segmentThree.hidden = YES;
            self.segmentFour.hidden = NO;
            self.segmentFive.hidden = NO;
            self.segmentSix.hidden = YES;
            self.segmentSeven.hidden = YES;
            break;
        case 8:
            for (int segment = 0; segment <=6; segment++) {
                UIView *thisSegment = self.segmentArray[segment];
                thisSegment.hidden = NO;
            }
            break;
        case 9:
            self.segmentOne.hidden = NO;
            self.segmentTwo.hidden = NO;
            self.segmentThree.hidden = YES;
            for (int segment = 4; segment <=6; segment++) {
                UIView *thisSegment = self.segmentArray[segment];
                thisSegment.hidden = NO;
            }
            break;
        default:
            for (int segment = 0; segment <=6; segment++) {
                UIView *thisSegment = self.segmentArray[segment];
                thisSegment.hidden = YES;
            }
            break;
    }
}

@end
