//
//  User.h
//  wlinetest
//
//  Created by Stefano on 27/03/17.
//  Copyright © 2017 wline. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface User : NSObject<NSCopying>

@property (nonatomic, strong) NSString *user_name;
@property (nonatomic, strong) NSString *user_username;
@property (nonatomic, strong) NSString *user_email;
@property (nonatomic, strong) NSString *user_street;
@property (nonatomic, strong) NSString *user_suite;
@property (nonatomic, strong) NSString *user_city;
@property (nonatomic, strong) NSString *user_zipcode;
@property (nonatomic, strong) NSString *user_phone;
@property (nonatomic, strong) NSString *user_website;
@property (nonatomic, strong) NSString *user_company_name;
@property (nonatomic, strong) NSString *user_company_catch_phrase;
@property (nonatomic, strong) NSString *user_company_bs;


-(id)initWithDict:(NSDictionary *)userDict;

@end
