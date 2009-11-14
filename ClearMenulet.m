//
//  ClearMenulet.m
//  clear-menulet
//
//  Created by Xavier Shay on 15/11/09.
//  Copyright 2009 NZX. All rights reserved.
//

#import "ClearMenulet.h"

@implementation ClearMenulet

- (void) awakeFromNib{
	
	//Create the NSStatusBar and set its length
	statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength] retain];
	
	//Used to detect where our files are
	NSBundle *bundle = [NSBundle mainBundle];
	
	//Allocates and loads the images into the application which will be used for our NSStatusItem
	marketOpenImage   = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"clock" ofType:@"png"]];
	marketClosedImage = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"clock_red" ofType:@"png"]];
	
	//Tells the NSStatusItem what menu to load
	[statusItem setMenu:statusMenu];

	//Enables highlighting
	[statusItem setHighlightMode:YES];
	
	marketOpen = false;
	
	updateTimer = [[NSTimer 
					scheduledTimerWithTimeInterval:(60.0)
					target:self
					selector:@selector(doUpdate:)
					userInfo:nil
					repeats:YES] retain];
	
	[updateTimer fire];
}

- (void) dealloc {
	//Releases the 2 images we loaded into memory
	[marketOpenImage release];
	[marketClosedImage release];
	[updateTimer release];
	[super dealloc];
}

-(IBAction)doUpdate:(id)sender{
	// TODO: Do I need to release this string?
	NSString *marketString = [NSString stringWithContentsOfURL:
							   [NSURL URLWithString:
							     @"https://app.cleargrain.com.au/login"]];
	
	marketOpen = ([marketString rangeOfString:@"Market Open"].location != NSNotFound);
	if (marketOpen) {
		[statusItem setImage:marketOpenImage];
		[statusItem setToolTip:@"CLEAR Grain market is open"];
	} else {
		[statusItem setImage:marketClosedImage];
		[statusItem setToolTip:@"CLEAR Grain market is closed"];
	}
}
@end
