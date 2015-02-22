//
//  PXContentTrackPackageList.m
//  PXPackage
//
//  Created by PJW on 5-14-14.
//  Copyright (c) 2014 PrettyX. All rights reserved.
//

#import "PXContentTrackPackageList.h"

@interface PXContentTrackPackageList()
@property (atomic, strong) NSMutableArray *packageDataArray;
@end

@implementation PXContentTrackPackageList
@synthesize TABLE_DATA_HEAD_OFFSET = _TABLE_DATA_HEAD_OFFSET;
@synthesize TABLE_DATA_TAIL_OFFSET = _TABLE_DATA_TAIL_OFFSET;
@synthesize packageDataArray = _packageDataArray;
@synthesize searchedPackageDataArray = _searchedPackageDataArray;
@synthesize searchText = _searchText;

- (NSUInteger)TABLE_DATA_HEAD_OFFSET{
	@synchronized(self){
		if (!_TABLE_DATA_HEAD_OFFSET) {
			_TABLE_DATA_HEAD_OFFSET = 0;
		}
		return _TABLE_DATA_HEAD_OFFSET;
	}
}

- (void)setTABLE_DATA_HEAD_OFFSET:(NSUInteger)TABLE_DATA_HEAD_OFFSET{
	@synchronized(self){
		_TABLE_DATA_HEAD_OFFSET = TABLE_DATA_HEAD_OFFSET;
	}
}

- (NSUInteger)TABLE_DATA_TAIL_OFFSET{
	@synchronized(self){
		if (!_TABLE_DATA_TAIL_OFFSET) {
			_TABLE_DATA_TAIL_OFFSET = 0;
		}
		return _TABLE_DATA_TAIL_OFFSET;
	}
}

- (void)setTABLE_DATA_TAIL_OFFSET:(NSUInteger)TABLE_DATA_HEAD_OFFSET{
	@synchronized(self){
		_TABLE_DATA_TAIL_OFFSET = TABLE_DATA_HEAD_OFFSET;
	}
}

- (NSMutableArray *) packageDataArray{
    @synchronized(self) {
		if (!_packageDataArray) {
			_packageDataArray = [[NSMutableArray alloc] init];
		}
        return _packageDataArray;
    }
}

- (void) setPackageDataArray:(NSMutableArray *)packageDataArray{
	@synchronized(self){
		_packageDataArray = [packageDataArray copy];
	}
}

- (NSMutableArray *) searchedPackageDataArray{
    @synchronized(self) {
		if (!_searchedPackageDataArray) {
			_searchedPackageDataArray = [[NSMutableArray alloc] init];
		}
		return _searchedPackageDataArray;
    }
}

- (void) setSearchedPackageDataArray:(NSMutableArray *)searchedPackageDataArray{
	@synchronized(self){
		_searchedPackageDataArray = [searchedPackageDataArray copy];
	}
}

- (NSString *)searchText{
	@synchronized(self){
		if (!_searchText) {
			_searchText = @"";
		}
		return _searchText;
	}
}

- (void)setSearchText:(NSString *)searchText{
	_searchText = [searchText copy];
	[self searchWith:[self searchText]];
}

- (void)awakeFromNib{
	// Set Data OFFSET
	[self setTABLE_DATA_HEAD_OFFSET:1];
	[self setTABLE_DATA_TAIL_OFFSET:1];
}

// Search with String
- (void)searchWith:(NSString *)text{

	[[self searchedPackageDataArray] removeAllObjects];

	if ([text isEqualTo:@""]) {

		for (PXPackageMeta *meta in [self packageDataArray]) {

			[[self searchedPackageDataArray] addObject:meta];
		}

	} else {
		for (PXPackageMeta *meta in [self packageDataArray]) {

			if ([[meta companyName] rangeOfString:text
										  options:NSCaseInsensitiveSearch].location != NSNotFound) {

				[[self searchedPackageDataArray] addObject:meta];
			} else if ([[meta company] rangeOfString:text
											 options:NSCaseInsensitiveSearch].location != NSNotFound) {

				[[self searchedPackageDataArray] addObject:meta];
			} else if ([[meta number] rangeOfString:text
											options:NSCaseInsensitiveSearch].location != NSNotFound) {

				[[self searchedPackageDataArray] addObject:meta];
			} else if ([[meta comment] rangeOfString:text
											 options:NSCaseInsensitiveSearch].location != NSNotFound) {

				[[self searchedPackageDataArray] addObject:meta];
			}
		}
	}

}

- (void) addItemToTable:(PXPackageMeta *)meta{

	[[self packageDataArray] addObject:meta];

	[self searchWith:[self searchText]];
}

- (void) addItemToTableWithCompany:(NSString *)company
							Number:(NSString *)number
						   Comment:(NSString *)comment{

	PXPackageMeta *meta = [[PXPackageMeta alloc] initWithContentOfCompany:company Number:number Comment:comment];
	[[self packageDataArray] addObject:meta];

	[self searchWith:[self searchText]];
}

- (void) removeItemAtRowIndexOfSearchedData:(NSUInteger)index {

	PXPackageMeta *meta = [[self searchedPackageDataArray] objectAtIndex:(index - [self TABLE_DATA_HEAD_OFFSET])];
	[[self packageDataArray] removeObject:meta];

	[self searchWith:[self searchText]];
}

- (NSArray *) currentPackageDataArray {

	return [self packageDataArray];
}

- (void) cleanPackageDataArray{

	[[self packageDataArray] removeAllObjects];
}

// Table Data Source
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {

	return [[self searchedPackageDataArray] count] + [self TABLE_DATA_HEAD_OFFSET] + [self TABLE_DATA_TAIL_OFFSET];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {

	if (row < [self TABLE_DATA_HEAD_OFFSET] || row == ([[self searchedPackageDataArray] count] + [self TABLE_DATA_HEAD_OFFSET])) {
		return nil;
	}



	PXPackageMeta *meta = [[self searchedPackageDataArray] objectAtIndex:(row - [self TABLE_DATA_HEAD_OFFSET])];

	NSAttributedString *companyString = [[NSAttributedString alloc]
										 initWithString:[meta companyName]
										 attributes:@{NSForegroundColorAttributeName:
														  [NSColor colorWithCalibratedRed:0.3 green:0.3 blue:0.3 alpha:1],
													  NSFontAttributeName:
														  [NSFont fontWithName:@"Lucida Grande" size:14.0]} ];

	NSAttributedString *numberString = [[NSAttributedString alloc]
										initWithString:[NSString
														stringWithFormat:@"%@: %@",
														NSLocalizedStringFromTable(PX_NUMBER, PX_VALUES, nil), [meta number]]
										attributes:@{NSForegroundColorAttributeName:
														 [NSColor colorWithCalibratedRed:0.61 green:0.57 blue:0.61 alpha:1],
													 NSFontAttributeName:
														 [NSFont fontWithName:@"Lucida Grande" size:12.0]} ];

//	NSString *comment = nil;
//	if ([[meta comment] length] <= 7) {
//		comment = [meta comment];
//	} else {
//		comment = [[meta comment] substringWithRange:NSMakeRange(0, 7)];
//	}

	NSAttributedString *commentString = [[NSAttributedString alloc]
										 initWithString:[NSString
														 stringWithFormat: @"%@: %@",
														 NSLocalizedStringFromTable(PX_MARK, PX_VALUES, nil), [meta comment]]
										 attributes:@{NSForegroundColorAttributeName:
														  [NSColor colorWithCalibratedRed:0.3 green:0.3 blue:0.3 alpha:1],
													  NSFontAttributeName:
														  [NSFont fontWithName:@"Lucida Grande" size:13.0]} ];

	NSMutableAttributedString *result = [[NSMutableAttributedString alloc] init];
	[result appendAttributedString:[[NSAttributedString alloc]
									initWithString:@"\n      "
									attributes:@{NSFontAttributeName:
													 [NSFont fontWithName:@"Lucida Grande" size:6.0]}]];
	[result appendAttributedString:companyString];
	[result appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n      "]];
	[result appendAttributedString:numberString];
	[result appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n      "]];
	[result appendAttributedString:commentString];

	return result;
}


// Table Delegate

- (BOOL)tableView:(NSTableView *)tableView shouldSelectRow:(NSInteger)row {

	if (row < [self TABLE_DATA_HEAD_OFFSET] || row == ([[self searchedPackageDataArray] count] + [self TABLE_DATA_HEAD_OFFSET])) {
		return NO;
	}

	return YES;
}

@end