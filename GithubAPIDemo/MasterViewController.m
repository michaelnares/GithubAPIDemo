//
//  MasterViewController.m
//  GithubAPIDemo
//
//  Created by Michael Nares on 23/08/2015.
//  Copyright (c) 2015 Michael Nares. All rights reserved.
//

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "RepoData.h"
#import "Utils.h"

@interface MasterViewController ()

@property NSMutableArray *objects;
- (IBAction)refresh:(UIRefreshControl *)sender;
@end

@implementation MasterViewController

- (void)viewDidLoad
{
    self.objects = [[NSMutableArray alloc]init];
    [super viewDidLoad];
    
    if ([Utils getNumOfRequestsInLastHour] >= 10) //i.e. only carry out the request if the query limit has not been reached, I only do 10 per hour as I am not authenticated, ref. the Github API docs
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Too many requests in the last hour" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    else
    {
    dispatch_async(kBgQueue, ^{
        NSString *urlString = [NSString stringWithFormat:@"https://api.github.com/search/repositories?q=%@+in:name",self.repoName];
        NSURL *url = [[NSURL alloc]initWithString:urlString];
        NSLog(@"%@", urlString);
        NSData* data = [NSData dataWithContentsOfURL: url];
        [Utils addTimestampToPersistedTimestampsArray:[[NSDate date]timeIntervalSince1970]];
        [self fetchData:data]; // fetching the data that has been queried, so that it can be parsed
    });
    } // else block ends here
    }

- (void)fetchData:(NSData *)responseData
    {
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData
                                                         options:kNilOptions
                                                           error:&error];
        if (error)
        {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Problem fetching data, please make sure internet connectivity enabled, then pull again to refresh." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
            return;
        }
        NSArray *results = [json valueForKey:@"items"];
        NSLog(@"%@", @"resultsArray initialised");
        NSLog(@"results: %@", results);
        
        
        for (NSDictionary *repoDic in results) // here I'm ensuring the data is added correctly, including log statements
        {
            RepoData *repoData = [[RepoData alloc]init];
            NSString *reposURL = [repoDic valueForKey:@"url"];
            NSString *readmeAPIURL = [reposURL stringByAppendingString:@"/readme"];
            NSLog(@"ReadmeAPIURL is %@", readmeAPIURL);
            NSNumber *numOfOpenIssues = (NSNumber*)[repoDic valueForKey:@"open_issues_count"];
            NSLog(@"Num of open issues is %@", numOfOpenIssues);
            NSNumber *numOfForks = (NSNumber*)[repoDic valueForKey:@"forks"];
            NSLog(@"Num of forks is %@", numOfForks);
            NSString *name = [repoDic valueForKey:@"name"];
            NSLog(@"Name is %@", name);
            [repoData setNumOfForks:numOfForks];
            [repoData setNumOfOpenIssues:numOfOpenIssues];
            [repoData setReadmeAPIURL:readmeAPIURL];
            [repoData setName:name];
            [self.objects addObject:repoData];
            }
        NSLog(@"objects: %@", self.objects);
        [self.tableView reloadData];
        NSLog(@"%@", @"reload data called");
        [Utils addTimestampToPersistedTimestampsArray:[[NSDate date] timeIntervalSince1970]];
        }


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
    {
    if ([[segue identifier] isEqualToString:@"showDetail"])
        {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        RepoData *object = self.objects[indexPath.row];
        DetailViewController *dvc = (DetailViewController*)[segue destinationViewController];
        dvc.name = object.name;
        dvc.numOfForks = object.numOfForks;
        dvc.numOfOpenIssues = object.numOfOpenIssues;
        dvc.readmeAPIURL = object.readmeAPIURL;
        }
    }


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    RepoData *object = self.objects[indexPath.row];
    cell.textLabel.text = object.name;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (IBAction)refresh:(UIRefreshControl *)sender
{
    [self.tableView reloadData];
    [sender endRefreshing];
}
@end
