//
//  PXContentTrackPackageContent.m
//  PXPackage
//
//  Created by PJW on 5-15-14.
//  Copyright (c) 2014 PrettyX. All rights reserved.
//

#import "PXContentTrackPackageContent.h"

@implementation PXContentTrackPackageContent
@synthesize TABLE_DATA_HEAD_OFFSET = _TABLE_DATA_HEAD_OFFSET;
@synthesize track = _track;

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

- (NSMutableArray *)track{
	@synchronized(self) {
		if (!_track) {
			_track = [[NSMutableArray alloc] init];
		}
		return _track;
	}
}

- (void)setTrack:(NSMutableArray *)track{
	@synchronized(self) {
		_track = [track copy];
	}
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {

	return [[self track] count] + [self TABLE_DATA_HEAD_OFFSET];
}

- (void)awakeFromNib{
	// Set Data OFFSET
	[self setTABLE_DATA_HEAD_OFFSET:1];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {

	if (row == 0) {
		if ([[tableColumn identifier] isEqualToString:@"time"]) {

			return NSLocalizedStringFromTable(PX_MOMENT, PX_VALUES, nil);
		} else if ([[tableColumn identifier] isEqualToString:@"action"]){

			return [NSString stringWithFormat:@"               %@",
					NSLocalizedStringFromTable(PX_ACTION, PX_VALUES, nil)];
		}

	}

	if ([[tableColumn identifier] isEqualToString:@"time"]) {

		return [[[self track] objectAtIndex:row - [self TABLE_DATA_HEAD_OFFSET] ] objectForKey:@"time"];
	} else if ([[tableColumn identifier] isEqualToString:@"action"]){

		return [[[self track] objectAtIndex:row - [self TABLE_DATA_HEAD_OFFSET] ] objectForKey:@"action"];
	}

	return nil;
}


@end
