//
//  User.m
//  wlinetest
//
//  Created by Stefano on 27/03/17.
//  Copyright © 2017 wline. All rights reserved.
//

#import "User.h"

@implementation User


-(id)initWithDict:(NSDictionary *)userDict
{
    self = [super init];
    if(self)
    {
        self.user_name = [userDict objectForKey:@"name"];
        self.user_username = [userDict objectForKey:@"username"];
        self.user_email = [userDict objectForKey:@"email"];
        self.user_phone = [userDict objectForKey:@"phone"];
        self.user_website = [userDict objectForKey:@"website"];


        NSDictionary *addressDict = [userDict objectForKey:@"address"];
        
        self.user_street = [addressDict objectForKey:@"street"];
        self.user_suite = [addressDict objectForKey:@"suite"];
        self.user_city = [addressDict objectForKey:@"city"];
        self.user_zipcode = [addressDict objectForKey:@"zipcode"];


        NSDictionary *companyDict = [userDict objectForKey:@"company"];
        
        self.user_company_name = [companyDict objectForKey:@"name"];
        self.user_company_catch_phrase = [companyDict objectForKey:@"catchPhrase"];
        self.user_company_bs = [companyDict objectForKey:@"bs"];
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone
{
    User *copyUser = [[User alloc] init];
    
    [copyUser setUser_name:_user_name];
    [copyUser setUser_username:_user_username];
    [copyUser setUser_email:_user_email];
    [copyUser setUser_phone:_user_phone];
    [copyUser setUser_website:_user_website];
    [copyUser setUser_street:_user_street];
    [copyUser setUser_suite:_user_suite];
    [copyUser setUser_city:_user_city];
    [copyUser setUser_zipcode:_user_zipcode];
    [copyUser setUser_company_name:_user_company_name];
    [copyUser setUser_company_catch_phrase:_user_company_catch_phrase];
    [copyUser setUser_company_bs:_user_company_bs];

    return copyUser;
}

@end
