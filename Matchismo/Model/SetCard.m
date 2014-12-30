//
//  SetCard.m
//  Matchismo
//
//  Created by deast on 12/30/14.
//  Copyright (c) 2014 Firebase. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SetCard.h"

@interface SetCard()

@end

@implementation SetCard

@synthesize color = _color, symbol = _symbol, shading = _shading;

- (NSString *)contents
{
  return self.symbol;
}

- (NSString *)description
{
  return self.contents;
}

- (NSString *)color
{
  return _color ? _color : @"?";
}

- (void)setColor:(NSString *)color
{
  if ([[SetCard validColors] containsObject:color]) {
    _color = color;
  }
}

- (NSString *)symbol
{
  return _symbol ? _symbol : @"?";
}

- (void)setSymbol:(NSString *)symbol
{
  if ([[SetCard validSymbols] containsObject:symbol]) {
    _symbol = symbol;
  }
}

- (NSString *)shading
{
  return _shading ? _shading : @"?";
}

- (void)setShading:(NSString *)shading
{
  if ([[SetCard validShadings] containsObject:shading]) {
    _shading = shading;
  }
}

+ (NSArray *)validSymbols
{
  return @[@"▲", @"●", @"■"];
}

+ (NSArray *)validColors
{
  return @[@"red", @"green", @"purple"];
}

+ (NSArray *)validShadings
{
  return @[@"solid", @"open", @"stripe"];
}

+ (NSUInteger)maxNumber
{
  return 3;
}

- (int)match:(NSArray *)otherCards
{
  int score = 0;
  NSUInteger numberOfCards = [otherCards count];
  
  if (numberOfCards) {
    for (Card *card in otherCards) {
      
      // Introspect
      if ([card isKindOfClass:[SetCard class]]) {
        SetCard *otherCard = (SetCard *)card;
        
        if ([self.contents isEqualToString:otherCard.contents]) {
          score += 1;
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

@end