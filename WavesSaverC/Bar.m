//
//  Bar.m
//  WavesSaverC
//
//  Created by Johann Garces on 9/26/18.
//  Copyright © 2018 johannmg. All rights reserved.
//

#import "Bar.h"

#import <ScreenSaver/ScreenSaver.h>

@implementation Bar
{
  int _min;
  int _max;
}

- (instancetype)initWithMinValue:(int)min
                        maxValue:(int)max
{
  self = [super init];
  if (self) {
    _min = min;
    _max = max;
    int startValue = (max-min)/2;
    _firstValue = startValue;
    _secondValue = startValue;
  }
  return self;
}

- (void)updateWithNoiseRatio:(float)ratio
{
  // first
  int randomIntInRange = SSRandomIntBetween( _min - _max , _max - _min);
  float delta = roundf(randomIntInRange) * ratio;
  _firstValue += (int)delta;
  
  // second
  int randomIntInRangeTwo = SSRandomIntBetween( _min - _max , _max - _min);
  float deltaTwo = roundf(randomIntInRangeTwo) * ratio;
  _secondValue += (int)deltaTwo;
  
}

@end
