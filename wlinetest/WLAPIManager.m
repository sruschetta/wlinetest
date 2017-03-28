//
//  WLAPIManager.m
//  wlinetest
//
//  Created by Stefano on 27/03/17.
//  Copyright © 2017 wline. All rights reserved.
//

#import "WLAPIManager.h"

@implementation WLAPIManager

#pragma mark - Singleton

+(WLAPIManager*)sharedManager
{
    static WLAPIManager *aSharedManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        aSharedManager = [[self alloc] init];
    });
    return aSharedManager;
}

#pragma mark - Utils


-(NSString*)endpoint
{
    return @"https://jsonplaceholder.typicode.com";
}


-(NSURLRequest*)urlRequestForMethod:(NSString*)method
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [self endpoint], method]];
    
    return [NSURLRequest requestWithURL:url];
}



#pragma mark - Api calls


-(void)getUsersWithCompletion:(void (^)(NSArray*, BOOL))completion
{
    NSString *usersString = @"/users";
    
    NSURLRequest *request = [self urlRequestForMethod:usersString];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
                              
                               if(!connectionError)
                               {
                                   NSError *serializationError;
                                   
                                   NSArray *resultArray = [NSJSONSerialization JSONObjectWithData:data
                                                                                          options:NSJSONReadingMutableLeaves
                                                                                            error:&serializationError];
                                   
                                   if(!serializationError)
                                   {
                                       completion(resultArray ,YES);
                                   }
                                   else
                                   {
                                       completion(nil, NO);
                                   }
                               }
                               else
                               {
                                   completion(nil, NO);
                               }
                           }];
}


@end
