//
//  RTMessageDisplayController.h
//  ReplyTo
//
//  Created by Shuo Yang on 08.12.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Adium/AIInterfaceControllerProtocol.h>


@interface RTMessageDisplayController : NSObject {
@private
    
}


- (void)setChatContentSource:(NSString *)source;
- (NSString *)chatContentSource;
- (NSString *)contentSourceName; // Unique name for this particular style of "content source".

- (NSView *)messageView;
- (NSView *)messageScrollView;
- (void)messageViewIsClosing;
- (void)clearView;

- (void)jumpToPreviousMark;
- (BOOL)previousMarkExists;

- (void)jumpToNextMark;
- (BOOL)nextMarkExists;

- (void)jumpToFocusMark;
- (BOOL)focusMarkExists;

- (void)addMark;
- (void)markForFocusChange;
@end



@end
