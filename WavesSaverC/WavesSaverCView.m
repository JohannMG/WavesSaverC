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
  [self artboxSetup];
  [self addSubview:_artbox];
  self.needsDisplay = YES;
}

- (void)drawRect:(NSRect)rect
{
  [super drawRect:rect];
  [self artboxLayout];
  [self.window setBackgroundColor:NSColor.blueColor];
  
}

- (void)artboxSetup
{
  NSLog(@"SS artboxSetup");
  if (!_artbox.isSetup){
    [self artboxLayout];
    [_artbox setup];
  }
  [_artbox setNeedsDisplay:YES];
}

-(void)artboxLayout
{
  const CGSize framesize = self.frame.size;
  const CGFloat offset = floor( framesize.width * kPaddingLeftRightPercent );
  _artbox.frame = CGRectMake(offset,
                             framesize.height * kPaddingTopBottomPercent,
                             floor(framesize.width - offset - offset),
                             floor(framesize.height - (2 * framesize.height * kPaddingTopBottomPercent)));
  [_artbox setNeedsDisplay:YES];
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
  [self artboxLayout];
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
