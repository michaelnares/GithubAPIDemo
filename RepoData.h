//
//  RepoData.h
//  GithubAPIDemo
//
//  Created by Michael Nares on 24/08/2015.
//  Copyright (c) 2015 Michael Nares. All rights reserved.
//

#import <Foundation/Foundation.h>

//Data class for storing data for each repo

@interface RepoData : NSObject

@property (nonatomic, strong) NSString* name;
@property NSNumber* numOfOpenIssues;
@property NSNumber* numOfForks;
@property (nonatomic, strong) NSString* readmeAPIURL;

@end
