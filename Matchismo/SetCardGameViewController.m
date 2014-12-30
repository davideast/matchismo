//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by deast on 12/28/14.
//  Copyright (c) 2014 Firebase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SetCardGameViewController.h"
#import "SetCardDeck.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

- (Deck *) createDeck
{
  return [[SetCardDeck alloc] init];
}

@end