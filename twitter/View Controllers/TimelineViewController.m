//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "Tweet.h"
#import "TweetCell.h"
#import <UIImageView+AFNetworking.h>
#import "ComposeViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *tweets;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *filteredData;
@property (strong, nonatomic) UIRefreshControl *refreshControl;



@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self. refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(beginRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview: self.refreshControl atIndex:0];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 130;
    
    [self beginRefresh];
  
}

-(void)beginRefresh {
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweetDictionaries, NSError *error) {
        if (tweetDictionaries) {
            // NSLog(@"😎😎😎 Successfully loaded home timeline");
            self.tweets = tweetDictionaries;
            self.tweets = [Tweet tweetsWithArray: tweetDictionaries];
            [self.tableView reloadData];
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
    [self.tableView reloadData];
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
   // cell.textLabel.text = @"Testing label";
    Tweet * tweet = self.tweets[indexPath.row];
    cell.tweet = tweet;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if(![segue.identifier isEqualToString:@"details"]){
    UINavigationController *navigationController = [segue destinationViewController];
    ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
    composeController.delegate = self;
}
    
}

       
-(void)didTweet:(Tweet *)tweet {
    [self.tweets addObject: tweet];
    [self.tableView reloadData];
}

- (IBAction)logOut:(id)sender {
   AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    [[APIManager shared] logout];
    
}


// Makes a network request to get updated data
// Updates the tableView with the new data
// Hides the RefreshControl

@end
