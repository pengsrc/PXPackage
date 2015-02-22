//
//  PXContentInputCompanyNameTextField.m
//  PXPackage
//
//  Created by PJW on 5-15-14.
//  Copyright (c) 2014 PrettyX. All rights reserved.
//

#import "PXContentInputCompanyNameTextField.h"

@implementation PXContentInputCompanyNameTextField

- (void)controlTextDidChange:(NSNotification *)obj {

}

- (NSArray *)control:(NSControl *)control
			textView:(NSTextView *)textView
		 completions:(NSArray *)words
 forPartialWordRange:(NSRange)charRange
 indexOfSelectedItem:(NSInteger *)index{

	return [PXDataCore expressServiceCompanyNameArray];
}

@end
