//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by deast on 12/29/14.
//  Copyright (c) 2014 Firebase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayingCardGameViewController.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *) createDeck
{
  return [[PlayingCardDeck alloc] init];
}

@end