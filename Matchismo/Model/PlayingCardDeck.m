//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by deast on 12/14/14.
//  Copyright (c) 2014 Firebase. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

- (instancetype)init
{
  self = [super init];
  
  if(self) {
    for (NSString *suit in [PlayingCard validSuits]) {
      for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
        PlayingCard *card = [[PlayingCard alloc] init];
        card.suit = suit;
        card.rank = rank;
        [self addCard: card];
      }
    }
  }
  
  return self;
}

@end