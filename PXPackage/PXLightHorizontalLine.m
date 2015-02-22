//
//  PXLightHorizontalLine.m
//  PXPackage
//
//  Created by PJW on 5-13-14.
//  Copyright (c) 2014 PrettyX. All rights reserved.
//

#import "PXLightHorizontalLine.h"

@implementation PXLightHorizontalLine

- (void)drawRect:(NSRect)dirtyRect{
	
    [super drawRect:dirtyRect];

	NSBezierPath *path = [NSBezierPath bezierPath];
	[path setLineWidth:1.0];

	NSPoint start, end;
	start.x = 0;
	start.y = [self bounds].size.height / 2;
	end.x = [self bounds].size.width;
	end.y = start.y;

	[path moveToPoint:start];
	[path lineToPoint:end];
	[path closePath];
	//	[[NSColor colorWithCalibratedRed:0.57 green:0.57 blue:0.57 alpha:1] set];
	[[NSColor colorWithCalibratedRed:0.74 green:0.74 blue:0.74 alpha:1] set];
	[path stroke];
}

@end
