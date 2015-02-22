//
//  PXContentTrackPackageList.h
//  PXPackage
//
//  Created by PJW on 5-14-14.
//  Copyright (c) 2014 PrettyX. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PXPackageMeta.h"

@interface PXContentTrackPackageList : NSTableView <NSTableViewDataSource, NSTableViewDelegate>

@property NSUInteger TABLE_DATA_HEAD_OFFSET;
@property NSUInteger TABLE_DATA_TAIL_OFFSET;

@property (atomic, strong) NSString *searchText;
@property  (atomic, strong) NSMutableArray *searchedPackageDataArray;

- (void) addItemToTable:(PXPackageMeta *)meta;
- (void) addItemToTableWithCompany:(NSString *)company
							Number:(NSString *)number
						   Comment:(NSString *)comment;
- (void) removeItemAtRowIndexOfSearchedData:(NSUInteger)index;

- (NSArray *) currentPackageDataArray;
- (void) cleanPackageDataArray;
@end
