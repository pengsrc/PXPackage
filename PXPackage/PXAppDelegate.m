//
//  PXAppDelegate.m
//  PXPackage
//
//  Created by PJW on 5-6-14.
//  Copyright (c) 2014 PrettyX. All rights reserved.
//

#import "PXAppDelegate.h"

@implementation PXAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification{
	// Initialization code here.
}


- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag{
    if(!flag){
        [NSApp activateIgnoringOtherApps:NO];
        [self.window makeKeyAndOrderFront:self];
		[[[NSApplication sharedApplication] dockTile]setBadgeLabel:NULL];
    }
    return YES;
}

@end
