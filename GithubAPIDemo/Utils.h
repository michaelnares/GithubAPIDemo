//
//  Utils.h
//  GithubAPIDemo
//
//  Created by Michael Nares on 24/08/2015.
//  Copyright (c) 2015 Michael Nares. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+(int)getNumOfRequestsInLastHour;
+(void)addTimestampToPersistedTimestampsArray:(long long)timestamp;

@end
