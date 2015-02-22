//
//  PXPackageDataCore.h
//  PXPackage
//
//  Created by PJW on 5-7-14.
//  Copyright (c) 2014 PrettyX. All rights reserved.
//

#import <Foundation/Foundation.h>

// Provide Express Company Information
@interface PXDataCore : NSObject

// Return All Company as a Array
+ (NSArray *)expressServiceCompanyArray;

// Return All CompanyName as a Array
+ (NSArray *)expressServiceCompanyNameArray;

// Return All Express Company Information
//		@{
//			@"company":@{
//						@"companyname":@"DATA",
//						@"tel":@"DATA",
//						@"url":@"DATA",
//						@"company":@"DATA",
//						@"companyurl":@"DATA",
//						@"testnu":@"DATA",
//						@"freg":@"DATA",
//						@"freginfo":@"DATA",
//						@"telcomplaintnum":@"DATA",
//						@"queryurl":@"DATA",
//						@"serversite":@"DATA",}
//		}
+ (NSDictionary *)expressServiceDictionary;
@end
