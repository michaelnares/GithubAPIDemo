//
//  DetailViewController.h
//  GithubAPIDemo
//
//  Created by Michael Nares on 23/08/2015.
//  Copyright (c) 2015 Michael Nares. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (nonatomic, strong) NSString* readmeAPIURL;
@property NSNumber* numOfOpenIssues;
@property NSNumber* numOfForks;
@property (nonatomic, strong) NSString* name;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *numOfOpenIssuesLabel;
@property (strong, nonatomic) IBOutlet UILabel *numOfForksLabel;

@end

