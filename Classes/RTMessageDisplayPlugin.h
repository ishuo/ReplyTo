//
//  RTMessageDisplayPlugin.h
//  ReplyTo
//
//  Created by Shuo Yang on 08.12.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Adium/AIInterfaceControllerProtocol.h>


@interface RTMessageDisplayPlugin : NSObject<AIMessageDisplayPlugin> {
@private
    
}

- (id <AIMessageDisplayController>)messageDisplayControllerForChat:(AIChat *)inChat;

@end
