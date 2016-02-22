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
        [self createWebView];
    }

    return self;
}

- (void)createWebView
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
    [self.webView loadRequest:req];
    [self.webView setHidden:YES]; //hide the webview until there's something to view. otherwise, blinding white.
    [self addSubview:self.webView]; //actually sets webview as renderable
    return;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self.webView setHidden:NO];
}

// The following functions are calling to `super` such that the background is drawn black.

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
    [self stopAnimation];
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
