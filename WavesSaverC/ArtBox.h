//
//  ArtBox.h
//  WavesSaverC
//
//  Created by Johann Garces on 9/26/18.
//  Copyright © 2018 johannmg. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <ScreenSaver/ScreenSaver.h>

NS_ASSUME_NONNULL_BEGIN

@interface ArtBox : NSView

@property (nonatomic) BOOL isPreview;
@property (nonatomic, readonly) BOOL isSetup;

- (void)setup;

@end

NS_ASSUME_NONNULL_END
