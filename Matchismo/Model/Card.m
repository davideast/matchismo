//
//  Card.m
//  Matchismo
//
//  Created by deast on 12/14/14.
//  Copyright (c) 2014 Firebase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Card()

@end

@implementation Card

- (int) match:(NSArray *)otherCards
{
  int score = 0;
  
  for (Card *card in otherCards) {
    if([card.contents isEqualToString:self.contents]) {
      score = 1;
    }
  }
  
  return score;
}

@end