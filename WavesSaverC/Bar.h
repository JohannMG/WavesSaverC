//
//  Bar.h
//  Data representation of each bar
//
//  Created by Johann Garces on 9/26/18.
//  Copyright © 2018 johannmg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface Bar : NSObject

@property (nonatomic, readonly) int firstValue;
@property (nonatomic, readonly) int secondValue;

- (instancetype)initWithMinValue:(int)min
                        maxValue:(int)max;

- (void)updateWithNoiseRatio:(float)ratio;

@end
NS_ASSUME_NONNULL_END
