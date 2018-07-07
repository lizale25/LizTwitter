//
//  DetailsViewController.m
//  twitter
//
//  Created by Lizbeth Alejandra Gonzalez on 7/6/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "TimelineViewController.h"
#import "APIManager.h"
#import "Tweet.h"
#import "TweetCell.h"
#import <UIImageView+AFNetworking.h>
#import "ComposeViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"


@interface DetailsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *tweets;
@property (strong, nonatomic) IBOutlet UITableView *detailtableView;
@property (strong, nonatomic) NSArray *filteredData;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *handle;
@property (weak, nonatomic) IBOutlet UILabel *following;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;


@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self. refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(beginRefresh) forControlEvents:UIControlEventValueChanged];
    [self.detailtableView insertSubview: self.refreshControl atIndex:0];
    
    self.detailtableView.dataSource = self;
    self.detailtableView.delegate = self;
    self.detailtableView.rowHeight = 130;
      NSString *a = @"@";
   
}

-(void)beginRefresh {
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweetDictionaries, NSError *error) {
        if (tweetDictionaries) {
            // NSLog(@"😎😎😎 Successfully loaded home timeline");
            self.tweets = tweetDictionaries;
            self.tweets = [Tweet tweetsWithArray: tweetDictionaries];
            [self.detailtableView reloadData];
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
    [self.detailtableView reloadData];
    [self.refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TweetCell *cell = [tableView
                       dequeueReusableCellWithIdentifier:@"TweetCell"];
    Tweet * tweet = self.tweets[indexPath.row];
    cell.tweet = tweet;
    return cell;
}


-(void)didTweet:(Tweet *)tweet {
    [self.tweets addObject: tweet];
    [self.detailtableView reloadData];
}


@end
