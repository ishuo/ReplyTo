//
//  RTMain.h
//  ReplyTo
//
//  Created by Shuo Yang on 02.12.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Adium/AIPlugin.h>

#import <Adium/AIContentControllerProtocol.h>

#import <WebKit/WebFrameLoadDelegate.h>
#import <WebKit/WebScriptObject.h>

@interface RTMain : AIPlugin<AIHTMLContentFilter> {
    
}

- (NSString *)filterHTMLString:(NSString *)inHTMLString content:(AIContentObject*)content;

+ (NSInteger)showAlertWithMessage:(NSString *)message;

- (void)webView:(WebView *)sender didClearWindowObject:(WebScriptObject *)windowObject forFrame:(WebFrame *)frame;

+ (BOOL)isSelectorExcludedFromWebScript:(SEL)aSelector;



@end
