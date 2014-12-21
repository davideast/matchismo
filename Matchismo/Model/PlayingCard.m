//
//  NSObject+PlayingCard.m
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
    for(PlayingCard* otherCard in otherCards) {
        // TODO: Introspect
        
        // calc score
        if([self.suit isEqualToString:otherCard.suit]) {
            score += 1;
        } else if(self.rank == otherCard.rank){
            score += 4;
        }
        
    }
    return score;
}

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
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
