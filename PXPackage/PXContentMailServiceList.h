//
//  PXContentMailServiceList.h
//  PXPackage
//
//  Created by PJW on 5-15-14.
//  Copyright (c) 2014 PrettyX. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PXDataCore.h"
#import "PXDataProvider.h"

@interface PXContentMailServiceList : NSTableView <NSTableViewDataSource, NSTableViewDelegate>
@property NSUInteger TABLE_DATA_HEAD_OFFSET;

@property (atomic, strong) NSString *searchText;
@property  (atomic, strong) NSMutableArray *searchedPackageDataArray;

@end
