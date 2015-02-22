//
//  PXSideBarView.m
//  PXPackage
//
//  Created by PJW on 5-12-14.
//  Copyright (c) 2014 PrettyX. All rights reserved.
//

#import "PXSideBarView.h"

@implementation PXSideBarView

- (void)drawRect:(NSRect)dirtyRect{

	// Set Background Color
    [super drawRect:dirtyRect];
	[[NSColor colorWithCalibratedRed:0.18 green:0.21 blue:0.23 alpha:1] setFill];
    [NSBezierPath fillRect:dirtyRect];
}

- (BOOL)isOpaque{
	return YES;
}

@end
