//
//  PXPackageMeta.h
//  PXPackage
//
//  Created by PJW on 5-6-14.
//  Copyright (c) 2014 PrettyX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PXDataProvider.h"

// Information for A Single Express Record
@interface PXPackageMeta : NSObject <NSCoding>

// Express Service Company Code & Name
@property (atomic, readonly, strong) NSString *company;
@property (atomic, readonly, strong) NSString *companyName;
// Express Mail Order Number
@property (atomic, readonly, strong) NSString *number;
// Comment to help Remember the Package
@property (atomic, readonly, strong) NSString *comment;
// Package State
//		0：在途, 即货物处于运输过程中
//		1：揽件, 货物已由快递公司揽收并且产生了第一条跟踪信息
//		2：疑难，货物寄送过程出了问题；
//		3：签收，收件人已签收；
//		4：退签，即货物由于用户拒签、超区等原因退回，而且发件人已经签收；
//		5：派件，即快递正在进行同城派件；
//		6：退回，货物正处于退回发件人的途中；
@property (atomic, readonly, strong) NSString *state;
// Track of the Package
//		Structure @{ @["time": "DATA", "action": "DATA"] ... }
@property (atomic, readonly, strong) NSArray *track;


- (id) initWithContentOfCompany:(NSString *) company
						 Number:(NSString *) number
						Comment:(NSString *) comment;

- (BOOL) updateInformation;

@end
