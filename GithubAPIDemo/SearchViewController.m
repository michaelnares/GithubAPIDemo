//
//  SearchViewController.m
//  GithubAPIDemo
//
//  Created by Michael Nares on 24/08/2015.
//  Copyright (c) 2015 Michael Nares. All rights reserved.
//

#import "SearchViewController.h"
#import "MasterViewController.h"

@implementation SearchViewController

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showTableViewData"])
    {
       if (![self.repoNameTextField.text isEqualToString:@""]) // checking for empty string
        {
        MasterViewController* masterViewController = (MasterViewController*)[segue destinationViewController];
        self.repoName = self.repoNameTextField.text;
        masterViewController.repoName = self.repoName;
        }
    }
}

-(void)viewDidLoad
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)]; // to dismiss keyboard when tapped outside of it
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard
{
    [self.repoNameTextField resignFirstResponder];
}

@end
