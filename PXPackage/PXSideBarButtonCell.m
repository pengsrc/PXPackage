//
//  PXSideButtonCell.m
//  PXPackage
//
//  Created by PJW on 5-13-14.
//  Copyright (c) 2014 PrettyX. All rights reserved.
//

#import "PXSideBarButtonCell.h"

@implementation PXSideBarButtonCell
- (void)awakeFromNib{

	// Set Title String
	NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:[self title]];
	[attributedString addAttribute:NSForegroundColorAttributeName
							 value:[NSColor colorWithCalibratedRed:0.47 green:0.53 blue:0.58 alpha:1]
							 range:NSMakeRange(0, [attributedString length])];
	[attributedString addAttribute:NSFontAttributeName
							 value:[NSFont fontWithName:@"Lucida Grande" size:13.0]
							 range:NSMakeRange(0, [attributedString length])];
	[self setAttributedTitle:attributedString];

	// Set Alternate Title String
	NSMutableAttributedString *attributedAlternateString = [[NSMutableAttributedString alloc]initWithString:[self title]];
	[attributedAlternateString addAttribute:NSForegroundColorAttributeName
							 value:[NSColor colorWithCalibratedRed:0.74 green:0.75 blue:0.75 alpha:1]
							 range:NSMakeRange(0, [attributedString length])];
	[attributedAlternateString addAttribute:NSFontAttributeName
							 value:[NSFont fontWithName:@"Lucida Grande" size:13.0]
							 range:NSMakeRange(0, [attributedString length])];
	[self setAttributedAlternateTitle:attributedAlternateString];

}

- (NSRect)drawTitle:(NSAttributedString *)title withFrame:(NSRect)frame inView:(NSView *)controlView {

	if (![self isEnabled]) {
		return [super drawTitle:[self attributedAlternateTitle] withFrame:frame inView:controlView];
	}

	return [super drawTitle:title withFrame:frame inView:controlView];
}

@end
