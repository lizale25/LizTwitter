//
//  ComposeViewController.h
//  twitter
//
//  Created by Lizbeth Alejandra Gonzalez on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "ComposeViewController.h"

@protocol ComposeViewControllerDelegate

- (void)didTweet:(Tweet *)tweet;
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;

@end
@interface ComposeViewController : UIViewController


@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;



@end
