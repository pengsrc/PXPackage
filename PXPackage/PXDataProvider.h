//
//  PXDataFetcher.h
//  PXPackage
//
//  Created by PJW on 5-6-14.
//  Copyright (c) 2014 PrettyX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PXValues.h"
#import "PXDataCore.h"
#import "PXPackageMeta.h"

// Fetch Data for Given Record
@interface PXDataProvider : NSObject

// Fetch Package Data and Return A Dictionary
//		@{
//			"company": "DATA",
//			"number": "DATA",
//			"state": "DATA",
//			"track": @{ "time": "DATA", "action": "DATA" ... }
//		}
+ (NSDictionary *) fetchPackageDataWithCompany:(NSString *) company
										Number:(NSString *) number;
+ (NSString *) interpretCompanyToCompanyName:(NSString *) company;
+ (NSString *) interpretCompanyNameToCompany:(NSString *) companyName;

+ (void) saveArrayToUserDefaults:(NSArray *) dataArray;
+ (NSArray *) loadArrayFromUserDefaults;

+ (BOOL)testNetworkConnection;
@end
