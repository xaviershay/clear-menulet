//
//  ClearMenulet.m
//  clear-menulet
//
//  Created by Xavier Shay on 15/11/09.
//  Copyright 2009 NZX. All rights reserved.
//

#import "ClearMenulet.h"
#import "JSON.h"

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
					scheduledTimerWithTimeInterval:(3.0)
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
	NSString *jsonString = [NSString stringWithContentsOfURL:
							[NSURL URLWithString:
							 @"http://localhost:3000/market_status.json"]];
	
	// Create SBJSON object to parse JSON
	SBJSON *parser = [[SBJSON alloc] init];
	
	NSDictionary *object = [parser objectWithString:jsonString];
	NSLog(@"Hello");
	NSLog([object objectForKey:@"market_status"]);
	
	marketOpen = [[object objectForKey:@"market_status"] isEqualToString:@"open"];
	if (marketOpen) {
		[statusItem setImage:marketOpenImage];
		[statusItem setToolTip:@"CLEAR Grain market is open"];
	} else {
		[statusItem setImage:marketClosedImage];
		[statusItem setToolTip:@"CLEAR Grain market is closed"];
	}
}
@end
