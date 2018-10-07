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
  _screensaverView = [[WavesSaverCView alloc] initWithFrame:CGRectMake(0, 0, 600, 400) isPreview:NO];
  [self.window.contentView addSubview:_screensaverView];
  
  WavesSaverCView __weak *_ssVview = _screensaverView;
  
  [NSTimer scheduledTimerWithTimeInterval:0.25
                                   target:_ssVview
                                 selector:@selector(animateOneFrame)
                                 userInfo:nil
                                  repeats:YES];
  
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
  // Insert code here to tear down your application
}


@end
