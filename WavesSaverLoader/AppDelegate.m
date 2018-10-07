//
//  AppDelegate.m
//  WavesSaverLoader
//
//  Created by Johann Garces on 10/6/18.
//  Copyright © 2018 johannmg. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate
{
  WavesSaverCView *_screensaverView;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  _screensaverView = [[WavesSaverCView alloc] initWithFrame:CGRectMake(0, 0, 800, 600) isPreview:NO];
  [self.window.contentView addSubview:_screensaverView];
  
  [_screensaverView startAnimation];
  
  [NSTimer scheduledTimerWithTimeInterval:1.0/ 30.0
                                   target:self
                                 selector:@selector(updateManual)
                                 userInfo:nil
                                  repeats:YES];
}

- (void)updateManual
{
  [_screensaverView animateOneFrame];
  [self.window.contentView setNeedsDisplay:YES];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
  // Insert code here to tear down your application
}


@end
