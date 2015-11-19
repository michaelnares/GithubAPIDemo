//
//  Utils.m
//  GithubAPIDemo
//
//  Created by Michael Nares on 24/08/2015.
//  Copyright (c) 2015 Michael Nares. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+(int)getNumOfRequestsInLastHour
{
    NSMutableArray *tempValuesArray = [[NSMutableArray alloc]init];
    NSMutableArray *persistedTimeStampsArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"persistedTimestamps"];
    for (int i = 0; i <= [persistedTimeStampsArray count]; i++)
    {
        long long value = (long long)persistedTimeStampsArray[i];
        long long nowTimestamp = [[NSDate date]timeIntervalSince1970];
        long long oneHourAgoTimestamp = nowTimestamp - (60 * 60);
        if (value > oneHourAgoTimestamp)
        {
            [tempValuesArray addObject:@(value)];
        }
    } // for loop ends here
    NSLog(@"Num of requests in last hour is currently %d", [tempValuesArray count]);
    return [tempValuesArray count]; // what I am doing here is counting up the number of requests in the last hour and adding them to the temp values data structure
    }

+(void)addTimestampToPersistedTimestampsArray:(long long)timestamp
{
        NSMutableArray *persistedTimeStampsArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"persistedTimestamps"];
    [persistedTimeStampsArray addObject:@(timestamp)];
    [[NSUserDefaults standardUserDefaults]setObject:persistedTimeStampsArray forKey:@"persistedTimestamps"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

@end
