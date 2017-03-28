//
//  WLUserViewController.m
//  wlinetest
//
//  Created by Stefano on 27/03/17.
//  Copyright © 2017 wline. All rights reserved.
//

#import "WLUserViewController.h"

#import "WLUserViewControllerCell.h"


typedef enum
{
    USER_NAME = 0,
    USER_USERNAME,
    USER_EMAIL,
    USER_STREET,
    USER_SUITE,
    USER_CITY,
    USER_ZIPCODE,
    USER_PHONE,
    USER_WEBSITE,
    USER_COMPANY_NAME,
    USER_COMPANY_CATCH_PHRASE,
    USER_COMPANY_BS,
    USER_FIELDS
}UserFields;

@interface WLUserViewController ()

    @property (nonatomic, weak) UITextField *activeField;

@end



@implementation WLUserViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setTitle:@"User Detail"];
    
    [_tableView setRowHeight:UITableViewAutomaticDimension];
    [_tableView setEstimatedRowHeight:80];
    
    [self registerForKeyboardNotifications];
}


#pragma mark - Table View Data Source


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseId = @"userReuseID";
    
    WLUserViewControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return USER_FIELDS;
}


#pragma mark - Table View Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLUserViewControllerCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    [cell.textField becomeFirstResponder];
}


#pragma mark - Cell Configuration

-(void)configureCell:(WLUserViewControllerCell*)cell atIndexPath:(NSIndexPath*)indexPath
{
    NSString *fieldTitle = @"";
    NSString *fieldContent = @"";
    
    switch (indexPath.row) {
            
        case USER_NAME:
            fieldTitle = @"Name:";
            fieldContent = _currentUser.user_name;
            break;
            
        case USER_USERNAME:
            fieldTitle = @"Username:";
            fieldContent = _currentUser.user_username;
            break;
            
        case USER_EMAIL:
            fieldTitle = @"Email:";
            fieldContent = _currentUser.user_email;
            break;
            
        case USER_SUITE:
            fieldTitle = @"Suite:";
            fieldContent = _currentUser.user_suite;
            break;
            
        case USER_STREET:
            fieldTitle = @"Street:";
            fieldContent = _currentUser.user_street;
            break;
            
        case USER_CITY:
            fieldTitle = @"City:";
            fieldContent = _currentUser.user_city;
            break;
            
        case USER_ZIPCODE:
            fieldTitle = @"Zip:";
            fieldContent = _currentUser.user_zipcode;
            break;
            
        case USER_PHONE:
            fieldTitle = @"Phone:";
            fieldContent = _currentUser.user_phone;
            break;
            
        case USER_WEBSITE:
            fieldTitle = @"Website:";
            fieldContent = _currentUser.user_website;
            break;
            
        case USER_COMPANY_NAME:
            fieldTitle = @"Co. Name:";
            fieldContent = _currentUser.user_company_name;
            break;
        
        case USER_COMPANY_CATCH_PHRASE:
            fieldTitle = @"Co. Catch Phrase:";
            fieldContent = _currentUser.user_company_catch_phrase;
            break;
            
        case USER_COMPANY_BS:
            fieldTitle = @"Co. Catch BS:";
            fieldContent = _currentUser.user_company_bs;
            break;        
    }
    
    [cell.descriptionLabel setText:fieldTitle];
    [cell.textField setText:fieldContent];
    [cell.textField setTag:indexPath.row];
}


#pragma mark - Text Field Delegate


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    _activeField = textField;
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag) {
            
        case USER_NAME:
            _currentUser.user_name = textField.text;
            break;
            
        case USER_USERNAME:
            _currentUser.user_username = textField.text;
            break;
            
        case USER_EMAIL:
            _currentUser.user_email = textField.text;
            break;
            
        case USER_SUITE:
            _currentUser.user_suite= textField.text;
            break;
            
        case USER_STREET:
            _currentUser.user_street = textField.text;
            break;
            
        case USER_CITY:
            _currentUser.user_city = textField.text;
            break;
            
        case USER_ZIPCODE:
            _currentUser.user_zipcode = textField.text;
            break;
            
        case USER_PHONE:
            _currentUser.user_phone = textField.text;
            break;
            
        case USER_WEBSITE:
            _currentUser.user_website = textField.text;
            break;
            
        case USER_COMPANY_NAME:
            _currentUser.user_company_name = textField.text;
            break;
            
        case USER_COMPANY_CATCH_PHRASE:
            _currentUser.user_company_catch_phrase = textField.text;
            break;
            
        case USER_COMPANY_BS:
            _currentUser.user_company_bs = textField.text;
            break;
    }
    
    _activeField = nil;
}


#pragma mark - Button Actions

-(IBAction)deleteAction:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning!"
                                                        message:@"Are you sure to delete this item?"
                                                       delegate:self
                                              cancelButtonTitle:@"No"
                                              otherButtonTitles:@"Delete", nil];
    
    [alertView show];
}


#pragma mark - AlertView Delegate


-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        [_usersArray removeObject:_currentUser];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark - Keyboard notifications


- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}


- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    _tableView.contentInset = contentInsets;
    _tableView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, _activeField.frame.origin) ) {
        [_tableView scrollRectToVisible:_activeField.frame animated:YES];
    }
}


- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    _tableView.contentInset = contentInsets;
    _tableView.scrollIndicatorInsets = contentInsets;
}
@end
