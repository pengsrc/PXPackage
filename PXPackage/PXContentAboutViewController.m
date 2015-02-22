//
//  PXContentAboutViewController.m
//  PXPackage
//
//  Created by PJW on 5-13-14.
//  Copyright (c) 2014 PrettyX. All rights reserved.
//

#import "PXContentAboutViewController.h"

@interface PXContentAboutViewController ()
@property (weak) IBOutlet NSTextField *appInfo;

@end

@implementation PXContentAboutViewController

- (id) init {
    self = [super initWithNibName:@"PXContentAboutView" bundle:nil];
    if (self) {}
    return self;
}

- (void)awakeFromNib {

	[[self appInfo] setStringValue:[NSString stringWithFormat:@"%@ %@ Build(%@)",
									@"PXPackage",
									[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"],
									[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]]];
}

- (IBAction)openUrl:(NSButton *)sender {

	[[NSWorkspace sharedWorkspace] openURL:[[NSURL alloc] initWithString:NSLocalizedStringFromTable(PX_PRETTYX_URL, PX_VALUES, nil)]];
}

- (IBAction)openEmail:(NSButton *)sender {

	[[NSWorkspace sharedWorkspace] openURL:[[NSURL alloc] initWithString:[NSString stringWithFormat:@"mailto:%@", NSLocalizedStringFromTable(PX_EMAIL_ADDRESS, PX_VALUES, nil)]]];
}

@end
