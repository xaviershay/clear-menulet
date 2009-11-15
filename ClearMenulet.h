//
//  ClearMenulet.h
//  clear-menulet
//
//  Created by Xavier Shay on 15/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import <Growl/Growl.h>

@interface ClearMenulet : NSObject <GrowlApplicationBridgeDelegate> {
	IBOutlet NSMenu *statusMenu;
	
	NSStatusItem *statusItem;
	NSImage *marketOpenImage;
	NSImage *marketClosedImage;
	NSImage *clearLogo;
	
	NSTimer *updateTimer;
	
	bool marketOpen;
}

-(IBAction)doUpdate:(id)sender;
-(void)notifyGrowl:(NSString *)text;
-(void)refreshMarketStatus;
@end
