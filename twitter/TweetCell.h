//
//  TweetCell.h
//  twitter
//
//  Created by Lizbeth Alejandra Gonzalez on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface TweetCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *handleDate;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;

@property (strong, nonatomic) Tweet * tweet;

@end
