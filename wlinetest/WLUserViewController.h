//
//  WLUserViewController.h
//  wlinetest
//
//  Created by Stefano on 27/03/17.
//  Copyright © 2017 wline. All rights reserved.
//

#import "WLViewController.h"

#import "User.h"

@interface WLUserViewController : WLViewController<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) User *currentUser;
@property (nonatomic, strong) NSMutableArray *usersArray;

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end
