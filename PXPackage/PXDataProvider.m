//
//  PXDataFetcher.m
//  PXPackage
//
//  Created by PJW on 5-6-14.
//  Copyright (c) 2014 PrettyX. All rights reserved.
//

#import "PXDataProvider.h"

@implementation PXDataProvider

+ (NSString *) packageQueryUrl{
	return @"http://www.kuaidi100.com/query";
}

+ (NSString *) packageQueryType{
	return @"type=";
}

+ (NSString *) packageQueryNumber{
	return @"postid=";
}

+ (NSDictionary *) fetchPackageDataWithCompany:(NSString *) company
										Number:(NSString *) number{

	@try {
		NSURL *packageQuery = [[NSURL alloc] initWithString:[[NSString alloc] initWithFormat:@"%@?%@%@&%@%@",
															 [PXDataProvider packageQueryUrl],
															 [PXDataProvider packageQueryType], company,
															 [PXDataProvider packageQueryNumber], number] ];
		NSData *jsonData = [NSData dataWithContentsOfURL:packageQuery];

		NSError *error;
		id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];

		if ( [jsonObject isKindOfClass:[NSDictionary class]] && error == nil) {
			NSDictionary *jsonDictonary = (NSDictionary *) jsonObject;
			NSMutableDictionary *mutableResult = [[NSMutableDictionary alloc] init];

			[mutableResult setObject:[jsonDictonary valueForKey:@"com"] forKey:@"company"];
			[mutableResult setObject:[jsonDictonary valueForKey:@"nu"] forKey:@"number"];
			[mutableResult setObject:[jsonDictonary valueForKey:@"state"] forKey:@"state"];

			NSMutableArray *track = [[NSMutableArray alloc]init];
			for (NSDictionary *item in [jsonDictonary valueForKey:@"data"]) {

				NSMutableDictionary *trackMetaDictionary = [[NSMutableDictionary alloc] init];
				[trackMetaDictionary setObject:[item objectForKey:@"time"] forKey:@"time"];
				[trackMetaDictionary setObject:[item objectForKey:@"context"] forKey:@"action"];
				[track addObject:trackMetaDictionary];
			}

			NSArray *trackSorted = [track sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {

				NSString *timeString1 = [obj1 objectForKey:@"time"];
				NSString *timeString2 = [obj2 objectForKey:@"time"];

				NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
				[dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];

				NSDate *date1 = [dateFormatter dateFromString:timeString1];
				NSDate *date2 = [dateFormatter dateFromString:timeString2];
				if ([[date1 laterDate:date2] isEqual:date2]) {
					return NSOrderedAscending;
				}
				return NSOrderedDescending;

			}];
			[mutableResult setObject:trackSorted forKey:@"track"];

			NSDictionary * result = [NSDictionary dictionaryWithDictionary:mutableResult];
			return result;
		}
	}
	@catch (NSException *exception) {}
	@finally {}

	return nil;
}

+ (NSString *) interpretCompanyToCompanyName:(NSString *) company{

	return [[PXDataCore expressServiceCompanyNameArray] objectAtIndex:[[PXDataCore expressServiceCompanyArray] indexOfObject:company]];
}

+ (NSString *) interpretCompanyNameToCompany:(NSString *) companyName{

	return [[PXDataCore expressServiceCompanyArray] objectAtIndex:[[PXDataCore expressServiceCompanyNameArray] indexOfObject:companyName]];
}

+ (void) saveArrayToUserDefaults:(NSArray *) dataArray{

	NSMutableArray *tempData = [[NSMutableArray alloc] init];
	for (PXPackageMeta *meta in dataArray) {
		NSData *data = [NSKeyedArchiver archivedDataWithRootObject:meta];
		[tempData addObject:data];
	}

	[[NSUserDefaults standardUserDefaults] setObject:tempData forKey:PX_USER_DEFAULTS_KEY];
}

+ (NSArray *) loadArrayFromUserDefaults{
	NSMutableArray *result = [[NSMutableArray alloc] init];

	NSMutableArray *tempData = [[NSUserDefaults standardUserDefaults] objectForKey:PX_USER_DEFAULTS_KEY];
	for (NSData *data in tempData) {
		PXPackageMeta *meta = [NSKeyedUnarchiver unarchiveObjectWithData:data];
		[result addObject:meta];
	}

	return result;
}

+ (BOOL)testNetworkConnection{

    NSURL *test = [[NSURL alloc]initWithString:@"http://www.baidu.com"];
    NSURLRequest *req = [NSURLRequest requestWithURL:test cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:3];
    NSURLResponse *resp = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:req returningResponse:&resp error:nil];
	
    if (data) {
		return YES;
	} else {
		return NO;
	}
}

@end
