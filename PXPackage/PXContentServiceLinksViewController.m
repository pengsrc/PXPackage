//
//  PXContentServiceLocationViewController.m
//  PXPackage
//
//  Created by PJW on 5-13-14.
//  Copyright (c) 2014 PrettyX. All rights reserved.
//

#import "PXContentServiceLinksViewController.h"

@implementation PXContentServiceLinksViewController

- (id)init{
	self = [super initWithNibName:@"PXContentServiceLinksView" bundle:nil];
	if (self) {}

	return self;
}

- (void)awakeFromNib{
}

- (IBAction)openUrl:(NSButton *)sender {

	NSURL *url = nil;

	if ([[sender identifier] isEqualToString:@"Kuaidi100"]) {

		url = [[NSURL alloc] initWithString:NSLocalizedStringFromTable(PX_KUAIDI100_URL, PX_VALUES, nil)];
	} else if ([[sender identifier] isEqualToString:@"Hao123Kuaidi"]) {

		url = [[NSURL alloc] initWithString:NSLocalizedStringFromTable(PX_HAO123KUAIDI_URL, PX_VALUES, nil)];
	} else if ([[sender identifier] isEqualToString:@"Aichakuaidi"]) {

		url = [[NSURL alloc] initWithString:NSLocalizedStringFromTable(PX_AICHAKUAIDI_URL, PX_VALUES, nil)];
	} else if ([[sender identifier] isEqualToString:@"Kuaidizhushou"]) {

		url = [[NSURL alloc] initWithString:NSLocalizedStringFromTable(PX_KUAIDIZHUSHOU_URL, PX_VALUES, nil)];
	}

	if (url != nil) {
		[[NSWorkspace sharedWorkspace] openURL:url];
	}
}

@end
