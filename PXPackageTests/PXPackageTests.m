//
//  PXPackageTests.m
//  PXPackageTests
//
//  Created by PJW on 5-6-14.
//  Copyright (c) 2014 PrettyX. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PXDataCore.h"
#import "PXDataProvider.h"
#import "PXPackageMeta.h"

@interface PXPackageTests : XCTestCase

@end

@implementation PXPackageTests

- (void)setUp{

    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown{

    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//- (void)testExample{
//	
//    XCTAssert(true, @"OK");
//}
//
//- (void)testLocalization{
//
//	NSLog(NSLocalizedStringFromTable(@"AppName", @"Values", nil));
//}
//
//- (void)testData{
//	NSArray *data = [PXDataCore expressServiceCompanyNameArray];
//	NSString *name = [PXDataProvider interpretCompanyNameToCompany:@"圆通速递"];
//	NSString *name1 = [PXDataProvider interpretCompanyToCompanyName:@"yuantong"];
//
//}

- (void)testPackageMeta{
	PXPackageMeta *meta = [[PXPackageMeta alloc] initWithContentOfCompany:@"yuantong" Number:@"5642867213" Comment:@"NONE"];

	[meta updateInformation];

}

@end
