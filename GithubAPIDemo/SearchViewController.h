//
//  SearchViewController.h
//  GithubAPIDemo
//
//  Created by Michael Nares on 24/08/2015.
//  Copyright (c) 2015 Michael Nares. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController

@property (nonatomic, strong) NSString* repoName;
@property (strong, nonatomic) IBOutlet UITextField *repoNameTextField;

@end
