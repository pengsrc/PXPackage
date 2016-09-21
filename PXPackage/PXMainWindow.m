//
//  PXMainWindow.m
//  PXPackage
//
//  Created by PJW on 5-7-14.
//  Copyright (c) 2014 PrettyX. All rights reserved.
//

#import "PXMainWindow.h"

@interface PXMainWindow()
@property (weak) IBOutlet NSView *donateView;
@end

@implementation PXMainWindow

- (void)awakeFromNib{
	[self addDonateViewToTitleBar];
}

- (void)addDonateViewToTitleBar {

	NSView *themeFrame = [[self contentView] superview];
	NSRect container = [themeFrame frame];
	NSRect frame = [[self donateView] frame];

	NSRect newFrame = NSMakeRect(container.size.width - frame.size.width,
								 container.size.height - frame.size.height,
								 frame.size.width,
								 frame.size.height);

	[[self donateView] setFrame:newFrame];
	[[self donateView] setAutoresizingMask:NSViewMinYMargin|NSViewMinXMargin ];

	[[[self contentView] superview] addSubview:[self donateView]];
}

- (id)initWithContentRect:(NSRect)contentRect
				styleMask:(NSWindowStyleMask)aStyle
				  backing:(NSBackingStoreType)bufferingType
					defer:(BOOL)flag{

	if (self = [super initWithContentRect:contentRect
								styleMask:aStyle
								  backing:bufferingType
									defer:flag]) {
		[self setBackgroundColor:[NSColor colorWithCalibratedRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
	}

	return self;
}

- (void)toggleFullScreen:(id)sender{

	if ([self isInFullScreenMode]) {
		[[self donateView] setHidden:NO];
	} else {
		[[self donateView] setHidden:YES];
	}

	[super toggleFullScreen:sender];
}

- (BOOL) isInFullScreenMode {

	return (([self styleMask] & NSFullScreenWindowMask) == NSFullScreenWindowMask);
}


- (IBAction)openDonateUrl:(NSButton *)sender {
	NSURL *donateUrl = [NSURL URLWithString:NSLocalizedStringFromTable(PX_DONATE_URL, PX_VALUES, nil)];
	[[NSWorkspace sharedWorkspace] openURL:donateUrl];
}

@end
