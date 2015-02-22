//
//  PXLightVerticalLine.m
//  PXPackage
//
//  Created by PJW on 5-12-14.
//  Copyright (c) 2014 PrettyX. All rights reserved.
//

#import "PXLightVerticalLine.h"

@implementation PXLightVerticalLine

- (void)drawRect:(NSRect)dirtyRect{
	
    [super drawRect:dirtyRect];

	NSBezierPath *path = [NSBezierPath bezierPath];
	[path setLineWidth:1.0];

	NSPoint start, end;
	start.x = [self bounds].size.width / 2;
	start.y = [self bounds].size.height;
	end.x = start.x;
	end.y = 0;

	[path moveToPoint:start];
	[path lineToPoint:end];
	[path closePath];
//	[[NSColor colorWithCalibratedRed:0.57 green:0.57 blue:0.57 alpha:1] set];
	[[NSColor colorWithCalibratedRed:0.74 green:0.74 blue:0.74 alpha:1] set];
	[path stroke];
}

@end
