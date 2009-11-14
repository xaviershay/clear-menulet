//
//  ClearMenulet.m
//  clear-menulet
//
//  Created by Xavier Shay on 15/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
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
	
	//Sets the images in our NSStatusItem
	[statusItem setImage:marketOpenImage];
	//[statusItem setAlternateImage:statusHighlightImage];
	
	//Tells the NSStatusItem what menu to load
	[statusItem setMenu:statusMenu];
	//Sets the tooptip for our item
	[statusItem setToolTip:@"My Custom Menu Item"];
	//Enables highlighting
	[statusItem setHighlightMode:YES];
	
	marketOpen = false;
	
	updateTimer = [[NSTimer 
					scheduledTimerWithTimeInterval:(1.0)
					target:self
					selector:@selector(helloWorld:)
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

-(IBAction)helloWorld:(id)sender{
	if (marketOpen)
		[statusItem setImage:marketOpenImage];
	else
		[statusItem setImage:marketClosedImage];
	marketOpen = !marketOpen;
	NSLog(@"Hello there!");
}
@end
