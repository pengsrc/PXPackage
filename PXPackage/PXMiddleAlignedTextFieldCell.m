//
//  PXMiddleAlignedTextFieldCell.m
//  PXPackage
//
//  Created by PJW on 5-15-14.
//  Copyright (c) 2014 PrettyX. All rights reserved.
//

#import "PXMiddleAlignedTextFieldCell.h"

@implementation PXMiddleAlignedTextFieldCell

-  (NSRect)titleRectForBounds:(NSRect)theRect {
    NSRect titleFrame = [super titleRectForBounds:theRect];
    NSSize titleSize = [[self attributedStringValue] size];
    titleFrame.origin.y = theRect.origin.y - 3 + (theRect.size.height - titleSize.height) / 2.0;
    return titleFrame;
}

- (void)drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
    NSRect titleRect = [self titleRectForBounds:cellFrame];
    [[self attributedStringValue] drawInRect:titleRect];
}

@end
