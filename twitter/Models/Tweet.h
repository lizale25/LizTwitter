//
//  Tweet.h
//  twitter
//
//  Created by Lizbeth Alejandra Gonzalez on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property (nonatomic, strong) NSString *idStr;
@property (strong, nonatomic) NSString *text;
@property (nonatomic) int favoriteCount;
@property (nonatomic) BOOL favorited;
@property (nonatomic) int retweetCount;
@property (nonatomic) BOOL retweeted;
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) NSString *createdAtString;
@property (strong, nonatomic) User *retweetedByUser;
@property (nonatomic) NSString *timeVal;
+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
