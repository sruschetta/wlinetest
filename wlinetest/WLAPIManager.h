//
//  WLAPIManager.h
//  wlinetest
//
//  Created by Stefano on 27/03/17.
//  Copyright © 2017 wline. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLAPIManager : NSObject


+(WLAPIManager*)sharedManager;



-(void)getUsersWithCompletion:(void (^)(NSArray*, BOOL))completion;


@end
