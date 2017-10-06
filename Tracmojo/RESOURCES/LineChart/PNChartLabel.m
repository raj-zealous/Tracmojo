//
//  PNChartLabel.m
//  PNChart
//
//  Created by kevin on 10/3/13.
//  Copyright (c) 2013年 kevinzhow. All rights reserved.
//

#import "PNChartLabel.h"
#import "PNColor.h"

@implementation PNChartLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
        // Initialization code

        [self setFont:[UIFont boldSystemFontOfSize:8.0f]];
        self.backgroundColor = [UIColor clearColor];
        [self setTextColor:[UIColor whiteColor]];
        [self setTextAlignment:NSTextAlignmentLeft];
        self.userInteractionEnabled = YES;
    }

    return self;
}

@end
