//
//  WLUsersViewController.m
//  wlinetest
//
//  Created by Stefano on 27/03/17.
//  Copyright © 2017 wline. All rights reserved.
//

#import "WLUsersViewController.h"

#import "WLUsersViewControllerCell.h"

#import "WLUserViewController.h"

#import "User.h"


@interface WLUsersViewController ()

@property (nonatomic, strong) NSMutableArray *usersArray;

@property (nonatomic, weak) User* userDetail;

@end


@implementation WLUsersViewController


#pragma mark - Life Cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setTitle:@"Users"];
    
    [_tableView setRowHeight:UITableViewAutomaticDimension];
    [_tableView setEstimatedRowHeight:100];
    
    [self getUsers];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_tableView reloadData];
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if( (sender == self) && [segue.identifier isEqual:@"toDetail"] )
    {
        if([segue.destinationViewController isKindOfClass:[WLUserViewController class]])
        {
            WLUserViewController *userViewController = segue.destinationViewController;
            [userViewController setUsersArray:_usersArray];
            [userViewController setCurrentUser:_userDetail];
            
            _userDetail = nil;
        }
    }
}




#pragma mark - Dataset Methods


-(void)getUsers
{
    //Api Call
    
    [[WLAPIManager sharedManager] getUsersWithCompletion:^(NSArray * resultArray, BOOL success) {
        
        _usersArray = [NSMutableArray array];
        
        if(success)
        {
            for(NSDictionary* userDict in resultArray)
            {
                User *user = [[User alloc] initWithDict:userDict];
                [_usersArray addObject:user];
            }
        }
        
        [_tableView reloadData];
    }];
}



#pragma mark - Table View Data Source

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseId = @"listReuseId";
    
    WLUsersViewControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.usersArray.count;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_usersArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}




#pragma mark - Cell configuration

-(void)configureCell:(WLUsersViewControllerCell*)cell atIndexPath:(NSIndexPath*)indexPath
{
    User *user = [self.usersArray objectAtIndex:indexPath.row];
    
    if(user)
    {
        [cell.usernameLabel setText:user.user_username];
        [cell.emailLabel setText:user.user_email];
    }
}




#pragma mark - Table View Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    _userDetail = [_usersArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"toDetail" sender:self];
}



@end
