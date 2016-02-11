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
    return;
}

- (void)stopAnimation
{
    return;
}

- (void)drawRect:(NSRect)rect
{
    //get tags from config file
    NSString *rel_path = @"~/.tumblrtvconfig";
    NSString *config_path = [rel_path stringByExpandingTildeInPath];
    [config_path writeToFile:@"/tmp/wat" atomically:true encoding:NSUTF8StringEncoding error:nil];
    NSString *tags = [NSString stringWithContentsOfFile:config_path encoding:NSUTF8StringEncoding error:nil];
    [tags writeToFile:@"/tmp/wat2" atomically:true encoding:NSUTF8StringEncoding error:nil];
    //select tag
    
    NSArray *split_tags = nil;
    if (tags != nil) {
        split_tags = [tags componentsSeparatedByString:@","];
    } else {
        split_tags = @[@"sakuga", @"cyberpunk", @"trippy", @"tumblr", @"staff"];
    }
    uint32_t rnd = arc4random_uniform([split_tags count]);
    NSString *tag = [split_tags objectAtIndex:rnd];
    NSString *trimmed_tag = [tag stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *sanitized_tag = [trimmed_tag stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    
    //generate url
    NSString *base_url = @"https://www.tumblr.com/tv/";
    NSString *target_url = [base_url stringByAppendingString:sanitized_tag];
    
    //build webview
    self.webView = [[WKWebView alloc] initWithFrame:self.frame];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    
    //set url
    NSURL *url = [NSURL URLWithString:target_url];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [self addSubview:self.webView]; //actually sets webview as renderable
    [self.webView loadRequest:req];
    return;
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
