//
//  WavesSaverCView.m
//  WavesSaverC
//
//  Created by Johann Garces on 9/26/18.
//  Copyright © 2018 johannmg. All rights reserved.
//

#import "WavesSaverCView.h"

static const CGFloat kPaddingLeftRightPercent = 0.1;
static const CGFloat kPaddingTopBottomPercent = 0.05;

@implementation WavesSaverCView
{
  ArtBox *_artbox;
  NSBox *_box;
}

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
      [self _setup];
      NSLog(@"SS init");
    }
    return self;
}

- (void)_setup
{
  NSLog(@"SS _setup");
  self.animationTimeInterval = 1.0/10.0;
  _artbox = [[ArtBox alloc] initWithFrame:NSZeroRect];
  _artbox.isPreview = self.isPreview;
  [self addSubview:_artbox];
  self.needsDisplay = YES;
  
  
  _box = [[NSBox alloc]initWithFrame:self.frame];
  _box.fillColor = NSColor.redColor;
  [self addSubview:_box];
}

- (void)drawRect:(NSRect)rect
{
  NSLog(@"SS drawRect");
  [super drawRect:rect];
  [self.window setBackgroundColor:NSColor.blueColor];
  if (!_artbox.isSetup){
    [self artboxSetup];
  }
  
  _box.frame = self.frame;
  
  int i = 0;
  while (i < 10000){
    i++;
  }
  
}

- (void)artboxSetup
{
  NSLog(@"SS artboxSetup");
  const CGSize framesize = self.frame.size;
  const CGFloat offset = floor( framesize.width * kPaddingLeftRightPercent );
  _artbox.frame = CGRectMake(offset,
                             framesize.height * kPaddingTopBottomPercent,
                             floor(framesize.width - offset - offset),
                             floor(framesize.height - (2 * framesize.height * kPaddingTopBottomPercent)));
  if (!_artbox.isSetup){
    [_artbox setup];
  }
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)animateOneFrame
{
  [self setNeedsDisplay:YES];
  return;
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

@end
