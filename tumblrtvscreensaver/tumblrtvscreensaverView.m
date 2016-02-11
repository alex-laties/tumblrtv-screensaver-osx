//
//  tumblrtvscreensaverView.m
//  tumblrtvscreensaver
//
//  Created by Alexander Laties on 2/10/16.
//  Copyright © 2016 Webscale AF, LLC. All rights reserved.
//

#import "tumblrtvscreensaverView.h"

@implementation tumblrtvscreensaverView

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAnimationTimeInterval:1/30.0];
    }
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
}

- (void)animateOneFrame
{
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
