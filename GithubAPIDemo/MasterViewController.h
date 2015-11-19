//
//  MasterViewController.h
//  GithubAPIDemo
//
//  Created by Michael Nares on 23/08/2015.
//  Copyright (c) 2015 Michael Nares. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSString* repoName;

@end

