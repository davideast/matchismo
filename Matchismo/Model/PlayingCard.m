//
//  PlayingCard.m
//  Matchismo
//
//  Created by deast on 12/14/14.
//  Copyright (c) 2014 Firebase. All rights reserved.
//

#import "PlayingCard.h"

@interface PlayingCard()

@end

@implementation PlayingCard

@synthesize suit = _suit;

- (int)match:(NSArray *)otherCards
{
  int score = 0;
  NSUInteger numberOfCards = [otherCards count];
  
  if (numberOfCards) {
    for (Card *card in otherCards) {
      
      // Introspect
      if ([card isKindOfClass:[PlayingCard class]]) {
        PlayingCard *otherCard = (PlayingCard *)card;
        
        if ([self.suit isEqualToString:otherCard.suit]) {
          score += 1;
        } else if (self.rank == otherCard.rank) {
          score += 4;
        }
        
      }
    }
  }
  
  // recursively match the other cards to each other by making
  // a range that removes the card we have already matched
  if (numberOfCards > 1) {
    NSRange range = NSMakeRange(1, numberOfCards -1);
    NSArray *subRange = [otherCards subarrayWithRange:range];
    score += [[otherCards firstObject] match:subRange];
  }
  
  
  return score;
}

- (NSString *)contents
{
  NSArray *rankStrings = [PlayingCard rankStrings];
  return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

- (NSString *)description
{
  return self.contents;
}

+ (NSArray *) validSuits
{
  return @[@"♥︎", @"♦︎", @"♠︎", @"♣︎"];
}

+ (NSArray *)rankStrings
{
  return @[@"?",@"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

- (NSString *)suit
{
  return _suit ? _suit : @"?";
}

+ (NSUInteger)maxRank
{
  return [[self rankStrings] count] - 1;
}

- (void)setSuit:(NSString *)suit
{
  if([[PlayingCard validSuits] containsObject: suit]) {
    _suit = suit;
  }
}

- (void)setRank:(NSUInteger)rank
{
  if(rank <= [PlayingCard maxRank]) {
    _rank = rank;
  }
}

@end
