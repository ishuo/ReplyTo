//
//  RTMain.m
//  ReplyTo
//
//  Created by Shuo Yang on 02.12.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RTMain.h"
#import <Adium/AIMenuControllerProtocol.h>

#import <Adium/AIInterfaceControllerProtocol.h>
#import <Adium/AIChat.h>
#import <AIUtilities/AIMenuAdditions.h>

#import <Adium/AISharedAdium.h>
#import <Adium/AIContentMessage.h>

#import <Adium/AIChatControllerProtocol.h>

#import <WebKit/WebKit.h>



@implementation RTMain



- (void)installPlugin
{
    [[adium contentController] registerHTMLContentFilter:self direction:AIFilterIncoming];
}


- (void)uninstallPlugin
{
    
    
}



- (NSString *)filterHTMLString:(NSString *)inHTMLString content:(AIContentObject*)content
{
    if ([content isKindOfClass:[AIContentMessage class]] && content.message.length) {
        
        AIChat *chat = content.chat;
        id<AIMessageDisplayController> messageDisplayController =  [[adium interfaceController] messageDisplayControllerForChat:chat];
        
        
        
        NSView *messageView = [messageDisplayController messageView];
        
        if ([messageView isKindOfClass:[WebView class]]) {
            WebView *messageWebView = (WebView *) messageView;
            
            [messageWebView setFrameLoadDelegate:self];
                       
            NSMutableString *mutableHTML = [inHTMLString mutableCopy];
            
            
            if (mutableHTML) {
                [mutableHTML appendFormat:@"<button type=\"button\" onClick=\"window.ReplyTo.testAlert()\">Click Me!</button>"];
            }
            
			return [mutableHTML autorelease];
        }
	}
	
	return inHTMLString;

}


- (CGFloat)filterPriority
{
    return DEFAULT_FILTER_PRIORITY;
}

             
           
- (void)webView:(WebView *)sender didClearWindowObject:(WebScriptObject *)windowObject forFrame:(WebFrame *)frame
{
    [windowObject setValue:self forKey:@"ReplyTo"];
   
}


+ (BOOL)isSelectorExcludedFromWebScript:(SEL)aSelector
{
    return NO;
}



- (void)testAlert
{
    [RTMain showAlertWithMessage:@"It works!!"];
}


+ (NSInteger)showAlertWithMessage:(NSString *)message
{
    // Create alert
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:message];
    //[alert setInformativeText:mutableHTML];
    [alert addButtonWithTitle:@"alright"];
    
    // Show alert
    NSInteger answer = [alert runModal];
    [alert release];
    alert = nil;

    return answer;
}




@end
