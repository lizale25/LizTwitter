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
}

-(void)setTweet:(Tweet *)tweet {
    _tweet = tweet;

    self.userName.text = self.tweet.user.name;
    NSString *a = @"@";
    self.handleDate.text = [a stringByAppendingString:self.tweet.user.screenName];
    [self.profilePicture setImageWithURL:tweet.user.profileImage];
    self.numberfavorite.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.numberRetweet.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2;
    self.profilePicture.clipsToBounds = YES;
    self.tweetText.text = self.tweet.text;
    self.timeStamp.text = self.tweet.timeVal;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
- (IBAction)didTapFavorite:(id)sender {
       self.numberfavorite.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
                if(error){
                    self.tweet.favorited = YES;
                    self.tweet.favoriteCount += 1;
                    [self.favoriteButton setSelected:YES];
                    self.numberfavorite.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
                    NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
                }
                else{
                    self.tweet.favoriteCount -= 1;
                    [self.favoriteButton setSelected:NO];
                    self.numberfavorite.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
                    NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
                }
                }];
        }
            else {
                self.tweet.favorited = YES;
                self.tweet.favoriteCount += 1;
                [self.favoriteButton setSelected:YES];
                self.numberfavorite.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
                 NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
     }];
}
- (IBAction)didTapRetweet:(id)sender {
     self.numberRetweet.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
             NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error) {
                 self.tweet.retweeted = YES;
                 self.tweet.retweetCount += 1;
                 [self.retweetButton setSelected:YES];
                 self.numberRetweet.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
                 NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
             }
             else {
                 self.tweet.retweetCount -= 1;
                 [self.retweetButton setSelected:NO];
                 self.numberRetweet.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
                 NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
             }
             }];
        }
        else{
            self.tweet.retweeted = YES;
            self.tweet.retweetCount += 1;
            [self.retweetButton setSelected:YES];
            self.numberRetweet.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
            NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
        }
     
    }];
}


@end
