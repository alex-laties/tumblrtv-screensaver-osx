//
//  tumblrtvscreensaverView.h
//  tumblrtvscreensaver
//
//  Created by Alexander Laties on 2/10/16.
//  Copyright © 2016 Webscale AF, LLC. All rights reserved.
//

#import <ScreenSaver/ScreenSaver.h>
@import WebKit;

@interface tumblrtvscreensaverView : ScreenSaverView

@property(strong, nonatomic) WKWebView *webView;

@end
