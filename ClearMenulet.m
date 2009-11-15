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
	clearLogo         = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"clear-logo" ofType:@"png"]];
	
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
	
	[self refreshMarketStatus];
	[updateTimer fire];
}

- (void) dealloc {
	//Releases the images we loaded into memory
	[marketOpenImage release];
	[marketClosedImage release];
	[clearLogo release];
	[updateTimer release];
	[super dealloc];
}

-(IBAction)doUpdate:(id)sender{
	bool lastMarketOpen = marketOpen;

	[self refreshMarketStatus];
	NSString* updateText;
	
	if (marketOpen) {
		[statusItem setImage:marketOpenImage];
		updateText = @"CLEAR Grain market is open";
	} else {
		[statusItem setImage:marketClosedImage];
		updateText = @"CLEAR Grain market is closed";
	}
	
	[statusItem setToolTip:updateText];
	if (marketOpen != lastMarketOpen)
		[self notifyGrowl:updateText];
}

- (void) notifyGrowl:(NSString *)text {
	[GrowlApplicationBridge setGrowlDelegate:self];
	[GrowlApplicationBridge notifyWithTitle:@""
								description:text
						   notificationName:@"Market Status"
								   iconData:[clearLogo TIFFRepresentation]
								   priority:0
								   isSticky:NO
							   clickContext:[NSDate date]];
}

-(void)refreshMarketStatus{
	NSString *marketString = [NSString stringWithContentsOfURL:
							  [NSURL URLWithString:
							   @"https://app.cleargrain.com.au/login"]];
	
	marketOpen = ([marketString rangeOfString:@"Market Open"].location != NSNotFound);
}
@end
