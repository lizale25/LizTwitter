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
    [ self.profilePicture setImageWithURL:tweet.user.profileImage];
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
