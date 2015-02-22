//
//  PXContentTrackPackageContent.h
//  PXPackage
//
//  Created by PJW on 5-15-14.
//  Copyright (c) 2014 PrettyX. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PXValues.h"

@interface PXContentTrackPackageContent : NSTableView <NSTableViewDataSource, NSTableViewDelegate>

@property NSUInteger TABLE_DATA_HEAD_OFFSET;

@property (atomic, strong) NSMutableArray *track;

@end
