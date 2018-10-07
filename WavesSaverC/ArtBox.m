//
//  ArtBox.m
//  WavesSaverC
//
//  Created by Johann Garces on 9/26/18.
//  Copyright © 2018 johannmg. All rights reserved.
//

#import "ArtBox.h"

#import <CoreGraphics/CoreGraphics.h>

#import "Bar.h"

static const CGFloat kMotionDampening = 0.005;
static const CGFloat kTwineThickness = 0.5;
static const CGFloat kPivotHeight = 14.0;
static const CGFloat kPivotWidth = 5.0;
static const CGFloat kConnectorThickness = 1.0;

//static const int kPivotsPerTwine = 2;

@implementation ArtBox
{
  NSMutableArray<Bar *> *_bars;
}

- (instancetype)initWithFrame:(NSRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    _isSetup = NO;
    _isPreview = NO;
    _bars = [NSMutableArray new];
  }
  return self;
}

- (void)setup
{
  if (_isSetup){
    return;
  }
  int barsThatCanFit = (int) floorf( self.bounds.size.width / [self _barWidth] );
  if (barsThatCanFit < 1) {
    return;
  }
  
  _isSetup = true;
  
  for (int i = 0; i < barsThatCanFit; i++){
    Bar *newBar = [[Bar alloc] initWithMinValue:CGRectGetMinY(self.bounds)
                                       maxValue:CGRectGetMaxY(self.bounds)];
    [_bars addObject:newBar];
  }
  
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
  
  [_bars enumerateObjectsUsingBlock:^(Bar * _Nonnull bar, NSUInteger index, BOOL * _Nonnull stop) {
    [bar updateWithNoiseRatio:kMotionDampening];
  }];
  
//  drawLines(withContext: NSGraphicsContext.current!.cgContext)
  [self _drawLinesWithContext:NSGraphicsContext.currentContext.CGContext];
  NSLog(@"_drawLinesWithContext");
//  drawConnectors(withContext: NSGraphicsContext.current!.cgContext)
  [self _drawConnectorsWithContext:NSGraphicsContext.currentContext.CGContext];
//  drawPivotsToContext(context: NSGraphicsContext.current!.cgContext)
  [self _drawPivotsToContext:NSGraphicsContext.currentContext.CGContext];
  
}

- (void)_drawLinesWithContext:(CGContextRef)context
{
  [_bars enumerateObjectsUsingBlock:^(Bar * _Nonnull bar, NSUInteger index, BOOL * _Nonnull stop) {
    CGFloat barWidth = [self _barWidth];
    CGRect subRect = CGRectMake(barWidth, (CGFloat)index , barWidth, self.frame.size.height);
    [self _drawTwineInRect:subRect withContext:context];
  }];
}

- (void)_drawTwineInRect:(CGRect)rect
             withContext:(CGContextRef)context
{
  CGMutablePathRef path = CGPathCreateMutable();
  CGPathMoveToPoint(path, nil, CGRectGetMidX(rect), CGRectGetMaxY(rect));
  CGPathAddLineToPoint(path, nil, CGRectGetMidX(rect), CGRectGetMinY(rect));
  CGPathCloseSubpath(path);
  
  CGContextSetLineWidth(context, kTwineThickness);
  CGColorRef twineColor = CGColorCreateGenericGray(0.8, 0.2);
  CGContextSetStrokeColorWithColor(context, twineColor);
  
  CGContextAddPath(context, path);
  CGContextDrawPath(context, kCGPathStroke);
}

- (void)_drawConnectorsWithContext:(CGContextRef)context
{
  const int connectionSeriesCount = 2;
  for (int i = 0; i < connectionSeriesCount; i++){
    CGMutablePathRef path = CGPathCreateMutable();
    
    for (int bar = 0; bar < _bars.count; bar++){
      Bar *b = _bars[bar];
      const CGFloat barYValue = (i == 0) ? b.firstValue : b.secondValue;
      
      const CGFloat barWidth = [self _barWidth];
      const CGFloat barXValue = (barWidth/2.0) + ((CGFloat)bar * barWidth);
      
      if (bar == 0){
        CGPathMoveToPoint(path, nil, barXValue , barYValue);
      } else {
        CGPathAddLineToPoint(path, nil, barXValue, barYValue);
      }
    }
    
    CGPathCloseSubpath(path);
    CGContextAddPath(context, path);
    CGContextSetLineWidth(context, kConnectorThickness);
    CGContextSetRGBStrokeColor(context, 0.7, 0.7, 0.87, 0.8);
    CGContextDrawPath(context, kCGPathStroke);
  }
}

- (void)_drawPivotsToContext:(CGContextRef)context
{
  for (int pivot = 0; pivot <= 1; pivot++) {
    for (int i = 0; i < _bars.count; i++) {
      const CGFloat yValue = (pivot == 0) ? _bars[i].firstValue : _bars[i].secondValue;
      [self _drawPivotToContext:context atColumn:i withValue:yValue];
    }
  }
  CGContextSetLineWidth(context, kPivotWidth);
  CGContextSetRGBStrokeColor(context, 1.0, 0.1, 0.1, 0.6);
  CGContextDrawPath(context, kCGPathStroke);
}

- (void)_drawPivotToContext:(CGContextRef)context
                   atColumn:(int)column
                  withValue:(CGFloat)value
{
  CGMutablePathRef path = CGPathCreateMutable();
  const CGFloat barWidth = [self _barWidth];
  const CGFloat xOffset = (barWidth/2.0) + ( (CGFloat)column * barWidth );
  
  CGPathMoveToPoint(path, nil, xOffset, (CGFloat)value - (kPivotHeight / 2.0));
  CGPathAddLineToPoint(path, nil, xOffset, (CGFloat)value + (kPivotHeight / 2.0));
  
  CGPathCloseSubpath(path);
  CGContextAddPath(context, path);
  
}

- (CGFloat)_barWidth
{
  return _isPreview ? 20 : 50;
}

@end
