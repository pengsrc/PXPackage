//
//  PXAppController.m
//  PXPackage
//
//  Created by PJW on 5-13-14.
//  Copyright (c) 2014 PrettyX. All rights reserved.
//

#import "PXAppController.h"

@interface PXAppController ()

// SideBar
@property (strong) NSDictionary *sideBarButtonDictionary;

@property (strong) NSString *trackPackageButtonIdentifier;
@property (strong) NSString *mailServiceButtonIdentifier;
@property (strong) NSString *serviceLinksIdentifier;
@property (strong) NSString *aboutButtonIdentifier;

@property (weak) IBOutlet NSButton *trackPackageButton;
@property (weak) IBOutlet NSButton *mailServiceButton;
@property (weak) IBOutlet NSButton *serviceLinksButton;
@property (weak) IBOutlet NSButton *aboutButton;


// ContentBox
@property (strong) NSDictionary *contentViewControllerDictonary;
@property (weak) IBOutlet NSBox *contentBox;

@end

@implementation PXAppController
@synthesize sideBarButtonDictionary = _sideBarButtonDictionary;
@synthesize trackPackageButtonIdentifier = _trackPackageButtonIdentifier;
@synthesize mailServiceButtonIdentifier = _mailServiceButtonIdentifier;
@synthesize serviceLinksButton = _serviceLinksButton;
@synthesize aboutButtonIdentifier = _aboutButtonIdentifier;
@synthesize contentViewControllerDictonary = _contentViewControllerDictonary;

- (void)awakeFromNib {

	// Setup Sidebar Button Dictionary
	[self setTrackPackageButtonIdentifier:@"trackPackageButton"];
	[self setMailServiceButtonIdentifier:@"mailServiceButton"];
	[self setServiceLinksIdentifier:@"serviceLinksButton"];
	[self setAboutButtonIdentifier:@"aboutButton"];

	[self setSideBarButtonDictionary:@{[self trackPackageButtonIdentifier]: [self trackPackageButton],
									   [self mailServiceButtonIdentifier]: [self mailServiceButton],
									   [self serviceLinksIdentifier]: [self serviceLinksButton],
									   [self aboutButtonIdentifier]: [self aboutButton]}];

	[[[self sideBarButtonDictionary] objectForKey:[self trackPackageButtonIdentifier]] setState:NSOnState];
	[[[self sideBarButtonDictionary] objectForKey:[self trackPackageButtonIdentifier]] setEnabled:NO];


	// Set Content Views
	[self setContentViewControllerDictonary:@{[self trackPackageButtonIdentifier]:
												  [[PXContentTrackPackageViewController alloc] init],
											  [self mailServiceButtonIdentifier]:
												  [[PXContentMailServiceViewController alloc] init],
											  [self serviceLinksIdentifier]:
												  [[PXContentServiceLinksViewController alloc] init],
											  [self aboutButtonIdentifier]:
												  [[PXContentAboutViewController alloc] init]}];

	[self displayViewController:
			[[self contentViewControllerDictonary] valueForKey:[self trackPackageButtonIdentifier]]];

}

- (void)displayViewController:(PXViewManageController *)viewController{
	// Swap Views
	[[self contentBox] setContentView:[viewController view]];
}

- (IBAction)sideBarButtonClicked:(NSButton *)sender {

	for (NSString *identifier in [[self sideBarButtonDictionary] allKeys]) {

		if ([identifier isEqualToString:[sender identifier]]) {

			[[[self sideBarButtonDictionary] objectForKey:identifier] setState:NSOnState];
			[[[self sideBarButtonDictionary] objectForKey:identifier] setEnabled:NO];
			[self displayViewController:[[self contentViewControllerDictonary] valueForKey:identifier]];
		} else {

			[[[self sideBarButtonDictionary] objectForKey:identifier] setState:NSOffState];
			[[[self sideBarButtonDictionary] objectForKey:identifier] setEnabled:YES];
		}
	}

}




@end
