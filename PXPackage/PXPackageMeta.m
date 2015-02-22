//
//  PXPackageMeta.m
//  PXPackage
//
//  Created by PJW on 5-6-14.
//  Copyright (c) 2014 PrettyX. All rights reserved.
//

#import "PXPackageMeta.h"

@interface PXPackageMeta()

@property (atomic, readwrite, strong) NSString *company;
@property (atomic, readwrite, strong) NSString *number;
@property (atomic, readwrite, strong) NSString *comment;
@property (atomic, readwrite, strong) NSString *state;
@property (atomic, readwrite, strong) NSArray *track;

@end

@implementation PXPackageMeta

@synthesize company = _company;
@synthesize companyName = _companyName;
@synthesize number = _number;
@synthesize comment = _comment;
@synthesize state = _state;
@synthesize track = _track;

- (NSString *) company{
    @synchronized(self) {
		if (!_company) {
			_company = [[NSString alloc] init];
		}
        return _company;
    }
}
- (void) setCompany:(NSString *)company{
	@synchronized(self){
		_company = [company copy];
	}
}

- (NSString *) companyName{
    @synchronized(self) {
		if (!_companyName) {
			_companyName = [[NSString alloc] init];
		}
        return _companyName;
    }
}
- (void) setCompanyName:(NSString *)companyName{
	@synchronized(self){
		_companyName = [companyName copy];
	}
}

- (NSString *) number{
    @synchronized(self) {
		if (!_number) {
			_number = [[NSString alloc] init];
		}
        return _number;
    }
}
- (void) setNumber:(NSString *)number{
	@synchronized(self){
		_number = [number copy];
	}
}

- (NSString *) comment{
    @synchronized(self) {
		if (!_comment) {
			_comment = [[NSString alloc] init];
		}
        return _comment;
    }
}
- (void) setComment:(NSString *)comment{
	@synchronized(self){
		_comment = [comment copy];
	}
}

- (NSString *) state{
	@synchronized(self) {
		if (!_state) {
			_state = [[NSString alloc] init];
		}
        return _state;
    }
}
- (void) setState:(NSString *)state{
	@synchronized(self){
		_state = [state copy];
	}
}

- (NSArray *) track{
	@synchronized(self) {
		if (!_track) {
			_track = [[NSArray alloc] init];
		}
        return _track;
    }
}
- (void) setTrack:(NSMutableArray *)track{
	@synchronized(self){
		_track = [track copy];
	}
}

- (id) initWithContentOfCompany:(NSString *) company
						 Number:(NSString *) number
						Comment:(NSString *) comment{

	[self setCompany:company];
	[self setCompanyName:[PXDataProvider interpretCompanyToCompanyName:company]];
	[self setNumber:number];
	[self setComment:comment];
	[self setState:@"0"];
	return self;
}

- (BOOL) updateInformation{
	NSDictionary *information = [PXDataProvider fetchPackageDataWithCompany:[self company] Number:[self number]];

	if (information != nil && [information count]>=4) {

		[self setState:[information valueForKey:@"state"]];
		[self setTrack:[information valueForKey:@"track"]];

		return YES;
	} else {
		return NO;
	}
}

- (id)initWithCoder:(NSCoder *)aDecoder{

	if (self = [super init]) {
		_companyName = [aDecoder decodeObjectForKey:@"companyName"];
		_company = [aDecoder decodeObjectForKey:@"company"];
		_number = [aDecoder decodeObjectForKey:@"number"];
		_comment = [aDecoder decodeObjectForKey:@"comment"];
		_state = [aDecoder decodeObjectForKey:@"state"];
		_track = [aDecoder decodeObjectForKey:@"track"];
	}

	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {

	[aCoder encodeObject:[self companyName] forKey:@"companyName"];
	[aCoder encodeObject:[self company] forKey:@"company"];
	[aCoder encodeObject:[self number] forKey:@"number"];
	[aCoder encodeObject:[self comment] forKey:@"comment"];
	[aCoder encodeObject:[self state] forKey:@"state"];
	[aCoder encodeObject:[self track] forKey:@"track"];
}

@end
