//
//  TweetCell.m
//  twitter
//
//  Created by Lizbeth Alejandra Gonzalez on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "Tweet.h"
#import "APIManager.h"
#import <UIImageView+AFNetworking.h>

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setTweet:(Tweet *)tweet {
    _tweet = tweet;
    //self.profilePicture.image = self.tweet.user.profileImage;
    self.userName.text = self.tweet.user.name;
    self.handleDate.text = self.tweet.user.screenName;
    [self.profilePicture setImageWithURL:tweet.user.profileImage];
    
    
    self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2;
    self.profilePicture.clipsToBounds = YES;
   // self.profilePicture.layer.borderWidth = 3.0f;
    //self.profilePicture.layer.borderColor = [UIColor whiteColor].CGColor;
    self.tweetText.text = self.tweet.text;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)didTapFavorite:(id)sender {
    self.tweet.favorited = YES;
    self.tweet.favoriteCount += 1;
}


@end
