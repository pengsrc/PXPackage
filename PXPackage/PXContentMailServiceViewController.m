//
//  PXContentMailServiceViewController.m
//  PXPackage
//
//  Created by PJW on 5-13-14.
//  Copyright (c) 2014 PrettyX. All rights reserved.
//

#import "PXContentMailServiceViewController.h"
@interface PXContentMailServiceViewController()

@property (atomic, strong) NSString *searchText;

@property (weak) IBOutlet PXContentMailServiceList *listTable;

@property (weak) IBOutlet NSTextField *infoCompanyName;
@property (weak) IBOutlet NSTextField *infoOfficialSite;
@property (weak) IBOutlet NSTextField *infoQuerySite;
@property (weak) IBOutlet NSTextField *infoServiceSite;
@property (weak) IBOutlet NSTextField *infoTelephone;
@property (weak) IBOutlet NSTextField *infoComplaint;

@end

@implementation PXContentMailServiceViewController
@synthesize searchText = _searchText;

- (NSString *)searchText{
	@synchronized(self) {
		if (!_searchText) {
			_searchText = [[NSString alloc] init];
		}
		return  _searchText;
	}
}

- (void)setSearchText:(NSString *)searchText{
	@synchronized(self) {
		if (searchText == nil) {
			_searchText = @"";
		} else {
			_searchText = [searchText copy];
		}

		[[self listTable] setSearchText:[self searchText]];
		[[self listTable] reloadData];
	}
}
- (id)init{
	self = [super initWithNibName:@"PXContentMailServiceView" bundle:nil];
	if (self) {}

	return self;
}

- (void)awakeFromNib{

	[[self listTable] setDelegate:[self listTable]];
	[[self listTable] setDataSource:[self listTable]];

	[[self listTable] setSearchText:@""];
	[[self listTable] reloadData];

	[self displayContent:[[PXDataCore expressServiceDictionary]
						  objectForKey:[[PXDataCore expressServiceCompanyArray] firstObject]]];
}

- (void)displayContent:(NSDictionary *)metaDictionary{

	[[self infoCompanyName] setStringValue:[metaDictionary objectForKey:@"companyname"]];
	[[self infoOfficialSite] setStringValue:[metaDictionary objectForKey:@"companyurl"]];
	[[self infoQuerySite] setStringValue:[metaDictionary objectForKey:@"queryurl"]];
	[[self infoServiceSite] setStringValue:[metaDictionary objectForKey:@"serversite"]];
	[[self infoTelephone] setStringValue:[metaDictionary objectForKey:@"tel"]];
	[[self infoComplaint] setStringValue:[metaDictionary objectForKey:@"telcomplaintnum"]];
}

- (IBAction)listTableClicked:(PXContentMailServiceList *)sender {

	if ([sender selectedRow] - [[self listTable] TABLE_DATA_HEAD_OFFSET] <= [[PXDataCore expressServiceCompanyNameArray] count]) {

		NSDictionary *metaDictionary = [[PXDataCore expressServiceDictionary]
										objectForKey: [PXDataProvider interpretCompanyNameToCompany:
													   [[[self listTable] searchedPackageDataArray]
														objectAtIndex:([sender selectedRow] - [[self listTable] TABLE_DATA_HEAD_OFFSET])]]];
		[self displayContent:metaDictionary];

	} else {

		[[self infoCompanyName] setStringValue:@""];
		[[self infoOfficialSite] setStringValue:@""];
		[[self infoQuerySite] setStringValue:@""];
		[[self infoServiceSite] setStringValue:@""];
		[[self infoTelephone] setStringValue:@""];
		[[self infoComplaint] setStringValue:@""];
	}
	
}

@end
