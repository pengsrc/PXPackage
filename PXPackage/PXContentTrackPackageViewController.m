//
//  PXContentTrackPackageViewController.m
//  PXPackage
//
//  Created by PJW on 5-13-14.
//  Copyright (c) 2014 PrettyX. All rights reserved.
//

#import "PXContentTrackPackageViewController.h"

@interface PXContentTrackPackageViewController () 

@property (atomic, strong) NSString *searchText;

@property (strong) IBOutlet NSWindow *addSheet;

@property (weak) IBOutlet PXContentTrackPackageList *listTable;
@property (weak) IBOutlet PXContentTrackPackageContent *contentTable;


@property (weak) IBOutlet NSComboBox *inputCompanyName;
@property (weak) IBOutlet NSTextField *inputNumber;
@property (weak) IBOutlet NSTextField *inputComment;

@property (weak) IBOutlet NSTextField *infoCompanyName;
@property (weak) IBOutlet NSTextField *infoNumber;
@property (weak) IBOutlet NSTextField *infoComment;
@property (weak) IBOutlet NSTextField *infoTotalTime;


@end

@implementation PXContentTrackPackageViewController
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

		// Update List Table
		[[self listTable] setSearchText:[self searchText]];
		[[self listTable] reloadData];
	}
}


- (id)init{
	self = [super initWithNibName:@"PXContentTrackPackageView" bundle:nil];
	if (self) {}
	return self;
}


- (void)timerAction{

	NSUInteger newCount = 0;

	for (PXPackageMeta *meta in [[self listTable] searchedPackageDataArray]) {
		NSUInteger count = [[meta track] count];
		[meta updateInformation];
		if (count < [[meta track] count]) {
			newCount ++ ;
		}
	}

	if (newCount > 0) {
		[[[NSApplication sharedApplication] dockTile]setBadgeLabel:[NSString stringWithFormat:@"%lu", newCount]];
		[[NSApplication sharedApplication] requestUserAttention:10];
	}
}

- (void)awakeFromNib {

	// Input CompanyName ComboBox
	[[self inputCompanyName] addItemsWithObjectValues:[PXDataCore expressServiceCompanyNameArray]];
	[[self inputCompanyName] reloadData];

	// Load User Data
	[self loadUserDataToListTable];

	// Setup List Table
	[[self listTable] setDelegate:[self listTable]];
	[[self listTable] setDataSource:[self listTable]];
	[[self listTable] setSearchText:[self searchText]];
	[[self listTable] reloadData];
	// Setup Content Table
	[[self contentTable] setDelegate:[self contentTable]];
	[[self contentTable] setDataSource:[self contentTable]];
	[[self listTable] reloadData];

	// Init Content Table
	if ([[[self listTable] searchedPackageDataArray] count] > 0 ) {

		[self displayInContentTable:[[[self listTable] searchedPackageDataArray] firstObject ]];
	}

	// Init Auto Refresh
	[NSTimer scheduledTimerWithTimeInterval:3600 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];

}

- (void)loadUserDataToListTable{

	NSArray *savedData = [PXDataProvider loadArrayFromUserDefaults];

	[[self listTable] cleanPackageDataArray];

	for (PXPackageMeta *meta in savedData){

		[[self listTable] addItemToTable:meta];
	}
}

- (void)saveUserDataFromListTable{

	[PXDataProvider saveArrayToUserDefaults:[[self listTable] currentPackageDataArray]];
}

- (void)addItemToTableWithCompany:(NSString *)company
						   Number:(NSString *)number
						  Comment:(NSString *)comment{

	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

		[[self listTable] addItemToTableWithCompany:company Number:number Comment:comment];

		[[self listTable] reloadData];

		[self saveUserDataFromListTable];

		[[[[self listTable] searchedPackageDataArray] lastObject] updateInformation];

//		dispatch_sync(dispatch_get_main_queue(), ^{ });
	});

}

- (void)removeItemAtTableRow:(NSUInteger)index{

	if (index - [[self listTable] TABLE_DATA_HEAD_OFFSET] <= [[[self listTable] searchedPackageDataArray] count]) {

		[[self listTable] removeItemAtRowIndexOfSearchedData:index];

		[[self listTable] reloadData];

		[self saveUserDataFromListTable];

	}
}

- (void)refreshItemAtTableRow:(NSUInteger)index{

	if (index - [[self listTable] TABLE_DATA_HEAD_OFFSET] <= [[[self listTable] searchedPackageDataArray] count]) {

		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

			[[[[self listTable] searchedPackageDataArray] objectAtIndex:(index - [[self listTable] TABLE_DATA_HEAD_OFFSET])] updateInformation];
			[self saveUserDataFromListTable];
			[self displayInContentTable:[[[self listTable] searchedPackageDataArray] objectAtIndex:(index - [[self listTable] TABLE_DATA_HEAD_OFFSET])]];
		});
	}

}

- (void)refreshAllData{

	if ([PXDataProvider testNetworkConnection] == NO) {
        
//		NSBeginAlertSheet(NSLocalizedStringFromTable(PX_INTERNET_CONNECTION_LOST, PX_VALUES, nil),
//						  NSLocalizedStringFromTable(PX_OK, PX_VALUES, nil), nil, nil,
//						  [[NSApp delegate]window], self,
//						  nil, nil, nil,
//						  NSLocalizedStringFromTable(PX_CHECK_YOUR_INTERNET_CONNECTION, PX_VALUES, nil));
		return;
	}

	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		for (PXPackageMeta *meta in [[self listTable] searchedPackageDataArray]) {
			[meta updateInformation];
		}
		[self saveUserDataFromListTable];
	});

}

- (void)displayInContentTable:(PXPackageMeta *)meta{

	[[[self contentTable] track] removeAllObjects];

	for (NSDictionary *trackMeta in [meta track]) {

		[[[self contentTable] track] addObject:trackMeta];
	}

	[[self infoCompanyName] setStringValue:[meta companyName]];
	if ([[meta state] isEqualToString:@"3" ] ) {
		[[self infoNumber] setStringValue:[NSString stringWithFormat:@"%@ (%@)", [meta number],
										   NSLocalizedStringFromTable(PX_CHECKED, PX_VALUES, nil)]];
	} else {
		[[self infoNumber] setStringValue:[meta number]];
	}
	[[self infoComment] setStringValue:[meta comment]];

	// Calculate Time
	NSString *timeString1 = [[[meta track] firstObject] valueForKey:@"time"];
	NSString *timeString2 = [[[meta track] lastObject] valueForKey:@"time"];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
	NSDate *date1 = [dateFormatter dateFromString:timeString1];
	NSDate *date2 = [dateFormatter dateFromString:timeString2];
	NSUInteger time = [date2 timeIntervalSinceDate:date1];

	NSMutableString *totalTime = [[NSMutableString alloc] init];

	if ((time / 3600 / 24) > 0) {
		NSUInteger days = (time / 3600 / 24);
		[totalTime appendFormat:@"%lu%@ ", days, NSLocalizedStringFromTable(PX_DAYS, PX_VALUES, nil)];
		time = time - 3600 * 24 * days;
	}

	if ((time / 3600 ) > 0) {
		NSUInteger hours = (time / 3600 );
		[totalTime appendFormat:@"%lu%@ ", hours, NSLocalizedStringFromTable(PX_HOURS, PX_VALUES, nil)];
		time = time - 3600 * hours;
	}

	if ((time / 60 ) > 0) {
		NSUInteger minutes = (time / 60 );
		[totalTime appendFormat:@"%lu%@ ", minutes, NSLocalizedStringFromTable(PX_MINUTES, PX_VALUES, nil)];
//		time = time - 60 * minutes;
	}

	[[self infoTotalTime] setStringValue:totalTime];

	[[self contentTable] reloadData];

}

- (IBAction)listTableClicked:(NSTableView *)sender {

	if (([sender selectedRow] >= [[self listTable] TABLE_DATA_HEAD_OFFSET] )
		&& ([sender selectedRow] <= [[[self listTable] searchedPackageDataArray] count])) {

		[self refreshItemAtTableRow:[sender selectedRow]];

		PXPackageMeta *meta = [[[self listTable] searchedPackageDataArray]
							   objectAtIndex:([sender selectedRow] -
											  [[self listTable] TABLE_DATA_HEAD_OFFSET])];

		[self displayInContentTable:meta];

	} else {

		[[self infoCompanyName] setStringValue:@""];
		[[self infoNumber] setStringValue:@""];
		[[self infoComment] setStringValue:@""];
		[[self infoTotalTime] setStringValue:@""];
		[[[self contentTable] track] removeAllObjects];
		[[self contentTable] reloadData];
	}

}


- (IBAction)refreshButtonClicked:(NSButton *)sender {

	[self refreshAllData];
}

- (IBAction)addButtonClicked:(NSButton *)sender {

	if (!_addSheet) {
		[[NSBundle mainBundle] loadNibNamed:@"PXContentTrackPackageAddView"
									  owner:self
							topLevelObjects:nil];
    }

    
	[NSApp beginSheet:[self addSheet]
	   modalForWindow:(NSWindow*)self.parentViewController
		modalDelegate:nil
	   didEndSelector:nil
		  contextInfo:nil];
}

- (IBAction)removeButtonClicked:(NSButton *)sender {

	NSUInteger selectedRow = [[self listTable] selectedRow];

	if (selectedRow - [[self listTable] TABLE_DATA_HEAD_OFFSET] <= [[[self listTable] searchedPackageDataArray] count]) {

		PXPackageMeta *meta = [[[self listTable] searchedPackageDataArray] objectAtIndex:(selectedRow - [[self listTable] TABLE_DATA_HEAD_OFFSET]) ];

		NSString *alertString = [NSString stringWithFormat:@"%@, %@, %@", [meta companyName], [meta number], [meta comment]];

		NSAlert *alertSheet = [NSAlert alertWithMessageText:NSLocalizedStringFromTable(PX_DO_YOU_RELLAY_WANT_TO_DELETE, PX_VALUES, nil)
											  defaultButton:NSLocalizedStringFromTable(PX_OK, PX_VALUES, nil)
											alternateButton:NSLocalizedStringFromTable(PX_CANCEL, PX_VALUES, nil)
												otherButton:nil
								  informativeTextWithFormat:@"%@", alertString];

		[alertSheet beginSheetModalForWindow:[[NSApplication sharedApplication] mainWindow]
						   completionHandler:^(NSModalResponse returnCode) {
							   if (returnCode == NSOKButton) {

								   [self removeItemAtTableRow:selectedRow];

								   [[self listTable] setSearchText:[self searchText]];
								   [[self listTable] reloadData];
							   }
						   }];
	}
}

- (IBAction)okSheet:(NSButton *)sender {

	if ([[[self inputCompanyName] stringValue] length ] > 0
		&& [[[self inputNumber] stringValue] length] > 0
//		&& [[[self inputComment] stringValue] length] > 0
		&& [[PXDataCore expressServiceCompanyNameArray]
			containsObject:[[self inputCompanyName] stringValue]]) {

		[self addItemToTableWithCompany:[PXDataProvider
										 interpretCompanyNameToCompany:
										 [[self inputCompanyName] stringValue]]
								 Number:[[self inputNumber] stringValue]
								Comment:[[self inputComment] stringValue] ];

		[[self listTable] setSearchText:[self searchText]];
		[[self listTable] reloadData];

		[NSApp endSheet:[self addSheet]];
		[[self addSheet] close];
		[self setAddSheet:nil];

	}
}

- (IBAction)closeSheet:(NSButton *)sender {
	
	[NSApp endSheet:[self addSheet]];
    [[self addSheet] close];
    [self setAddSheet:nil];
}



@end
