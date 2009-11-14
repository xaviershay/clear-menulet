//
//  ClearMenulet.h
//  clear-menulet
//
//  Created by Xavier Shay on 15/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface ClearMenulet : NSObject {
	IBOutlet NSMenu *statusMenu;
	
	NSStatusItem *statusItem;
	NSImage *marketOpenImage;
	NSImage *marketClosedImage;
	
	NSTimer *updateTimer;
	
	bool marketOpen;
}

-(IBAction)helloWorld:(id)sender;

@end
