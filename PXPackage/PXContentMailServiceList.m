//
//  PXContentMailServiceList.m
//  PXPackage
//
//  Created by PJW on 5-15-14.
//  Copyright (c) 2014 PrettyX. All rights reserved.
//

#import "PXContentMailServiceList.h"

@interface PXContentMailServiceList()
@end

@implementation PXContentMailServiceList
@synthesize TABLE_DATA_HEAD_OFFSET = _TABLE_DATA_HEAD_OFFSET;
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
	[self setTABLE_DATA_HEAD_OFFSET:2];
}

- (void)searchWith:(NSString *)text{

	[[self searchedPackageDataArray] removeAllObjects];

	if ([text isEqualTo:@""]) {

		for (NSString *companyName in [PXDataCore expressServiceCompanyNameArray]) {

			[[self searchedPackageDataArray] addObject:companyName];
		}
		
	} else {

		for (NSString *companyName in [PXDataCore expressServiceCompanyNameArray]) {

			if ([companyName rangeOfString:text
								   options:NSCaseInsensitiveSearch].location != NSNotFound ) {

				[[self searchedPackageDataArray] addObject:companyName];
			} else if ([[PXDataProvider interpretCompanyNameToCompany:companyName]
						rangeOfString:text
						options:NSCaseInsensitiveSearch].location != NSNotFound ) {

				[[self searchedPackageDataArray] addObject:companyName];
			}
		}

	}

}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {

	return [[self searchedPackageDataArray] count] + [self TABLE_DATA_HEAD_OFFSET];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {

	if (row < [self TABLE_DATA_HEAD_OFFSET]) {
		return nil;
	}

	return [NSString stringWithFormat:@"   %@",
			[[self searchedPackageDataArray] objectAtIndex:(row - [self TABLE_DATA_HEAD_OFFSET]) ]];
}

- (BOOL)tableView:(NSTableView *)tableView shouldSelectRow:(NSInteger)row {

	if (row < [self TABLE_DATA_HEAD_OFFSET]) {
		return NO;
	}

	return YES;
}


@end
