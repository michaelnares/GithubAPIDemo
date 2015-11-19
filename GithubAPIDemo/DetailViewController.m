//
//  DetailViewController.m
//  GithubAPIDemo
//
//  Created by Michael Nares on 23/08/2015.
//  Copyright (c) 2015 Michael Nares. All rights reserved.
//

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

#import "DetailViewController.h"
#import "Utils.h"

@interface DetailViewController ()
- (IBAction)dismissViewController:(id)sender;
- (IBAction)viewReadmeInBrowser:(id)sender;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)viewDidLoad
    {
    [super viewDidLoad];
    self.nameLabel.text = self.name;
    self.numOfOpenIssuesLabel.text = [self.numOfOpenIssues stringValue];
    self.numOfForksLabel.text = [self.numOfOpenIssues stringValue];
    }

- (IBAction)dismissViewController:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil]; // dismissing ViewController in response to x being pressed
}

- (IBAction)viewReadmeInBrowser:(id)sender
{
    dispatch_async(kBgQueue, ^{
        if ([Utils getNumOfRequestsInLastHour] >= 10) // need to make sure I don't go over 10 an hour as I am an unauthenticated user
        {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Too many requests in the last hour" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show]; // show alert view to user indicating that he/she has gone over the limit
        }
        
        else
        {
        NSURL *url = [[NSURL alloc]initWithString:self.readmeAPIURL];
        NSData* data = [NSData dataWithContentsOfURL: url];
        [Utils addTimestampToPersistedTimestampsArray:[[NSDate date]timeIntervalSince1970]]; // ensuring persisted timestamps array kept up to date
        [self performSelectorOnMainThread:@selector(fetchDataAndVisitUrl:) withObject:data waitUntilDone:YES];
            }// ends else block
        }); // ends dispatchAsync block
}

-(void)fetchDataAndVisitUrl:(NSData*)responseData
{
    
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData
                                                         options:kNilOptions
                                                           error:&error];
    NSString* readmeURL = [json valueForKey:@"html_url"]; // because this is the HTML URL for the readme
    NSLog(@"Readme URL = %@", readmeURL); // ensuring the readme is logged correctly
    NSURL *url = [NSURL URLWithString:readmeURL];
    [[UIApplication sharedApplication]openURL:url]; // opening the readme URL in the browser

}
@end
