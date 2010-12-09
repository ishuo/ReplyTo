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

@synthesize currentChat;


- (void)installPlugin
{
    
    
    // Create our new menu item
	NSMenuItem *timezoneMenuItem = [[NSMenuItem alloc] initWithTitle:@"Test!!" 
                                                              target:self
                                                              action:@selector(test) 
                                                       keyEquivalent:@""];
	
	// Install the menu item to the contextual menu
	[[adium menuController] addContextualMenuItem:timezoneMenuItem toLocation:Context_Contact_Action];
	[timezoneMenuItem release];
    
    
       //[[adium contentController] registerContentFilter:self ofType:AIFilterContent direction:AIFilterOutgoing];

    
    [[adium contentController] registerHTMLContentFilter:self direction:AIFilterIncoming];
    
}


- (void)uninstallPlugin
{
    
    
}


- (void)test
{
    
    NSBeep();
    
    AIChat *chat = [[adium interfaceController] activeChat];
    
    NSString *name = [chat displayName];
    if (!name) name = @"nil";
    
    // Create alert
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:name];
    [alert setInformativeText:@"informative text"];
    [alert addButtonWithTitle:@"alright"];
    

    
    // Show alert
    NSInteger answer = [alert runModal];
    [alert release];
    alert = nil;
    
}


- (NSAttributedString *)filterAttributedString:(NSAttributedString *)inAttributedString context:(id)context
{
    BOOL isMessage = [context isKindOfClass:[AIContentMessage class]] && ![(AIContentMessage *)context isAutoreply];
   
    if (!isMessage) return inAttributedString;
    
    
    
    NSString *messageString = [context messageString];
    
    NSString *transformedMessage = [messageString capitalizedString];
    NSDictionary *defaultFormatting = [[adium contentController] defaultFormattingAttributes];
    
    NSAttributedString *newMessage = [[NSAttributedString alloc] initWithString:transformedMessage attributes:defaultFormatting];
    
    return [newMessage autorelease];
    
    return inAttributedString;
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
                //NSRange range = [mutableHTML rangeOfString:@"</body>" options:NSBackwardsSearch];
                //NSUInteger index = range.location;
                [mutableHTML appendFormat:@"<button type=\"button\" onClick=\"window.ReplyTo.testAlert()\">Click Me!</button>"];
                
                
                //            [mutableHTML appendFormat:@"index: %i", index];
                //            if (index != NSNotFound) {
                //                [mutableHTML insertString:@"<button type=\"button\">Click Me!</button>" atIndex:index];
                //            }
                
                
            }
            
            
            
			return [mutableHTML autorelease];
        }
        
        

        
//		if ([[attributes objectForKey:AITwitterActionLinksAttributeName] boolValue]) {
			// We're in a valid message; let's replace!
			

//		}
	}
	
	return inHTMLString;

    
    
}
             
           
- (void)webView:(WebView *)sender didClearWindowObject:(WebScriptObject *)windowObject forFrame:(WebFrame *)frame
{
        
    //dispatch_sync(dispatch_get_main_queue(), ^ {

        [windowObject setValue:self forKey:@"ReplyTo"];

    //});
        
    //[windowObject set
    
    //[windowObject evaluateWebScript:@"window.ReplyTo.testAlert()"]; 
   
}


+ (BOOL)isSelectorExcludedFromWebScript:(SEL)aSelector
{
    [self showAlertWithMessage:@"selector excluded?"];
    return NO;
}



- (void) testAlert
{
    
    [self showAlertWithMessage:@"It works!!"];
    
}


+ (NSInteger) showAlertWithMessage:(NSString *)message
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


- (CGFloat)filterPriority
{
    return DEFAULT_FILTER_PRIORITY;
}



@end
