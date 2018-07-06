//
//  ComposeViewController.m
//  twitter
//
//  Created by Lizbeth Alejandra Gonzalez on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *tweetButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *wordCount;

@end

@implementation ComposeViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)closeButton:(id)sender {
  [self dismissViewControllerAnimated:true completion:nil];
    
}
- (IBAction)tweetButton:(id)sender {
    [[APIManager shared] postStatusWithText:self.textView.text completion:^(Tweet * tweet, NSError * error) {
        if(tweet) {
            [self dismissViewControllerAnimated:true completion:nil];
        }
            else {
                NSLog(@"😫😫😫 Error posting tweet: %@", error.localizedDescription);
        }
    }];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    int characterLimit = 140;
    NSString *newText = [self.textView.text stringByReplacingCharactersInRange:range withString:text];
    NSString *counter = @"Word count: ";
    self.wordCount.text =  [counter stringByAppendingString:[NSString stringWithFormat:@"%d", newText.length]];
    return newText.length < characterLimit;
    

}

@end
