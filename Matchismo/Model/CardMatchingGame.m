//
//  NSObject+CardMatchingGame.m
//  Matchismo
//
//  Created by deast on 12/16/14.
//  Copyright (c) 2014 Firebase. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@property (nonatomic, strong) NSMutableArray *chosenCards; // of Card
@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;
static const int CARDS_TO_CHOOSE = 3;

- (NSMutableArray*)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray*)chosenCards
{
    if(!_chosenCards) _chosenCards = [[NSMutableArray alloc] init];
    return _chosenCards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

- (void) chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if(!card.isMatched) {
        [self.chosenCards addObject:card];
        
        if(card.isChosen) {
            // set chosen to NO, making it flip face down
            [self unchooseCard:card];
        } else {
            
            NSUInteger chosenCardCount = [self.chosenCards count];
            if(chosenCardCount == CARDS_TO_CHOOSE) {
                [self checkCardMatchForCards:card :self.chosenCards];
            }
            
            // penalty for every flip of a card
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
            
        }
    }
}

- (void)unchooseCard:(Card *)card
{
    card.chosen = NO;
    [self.chosenCards removeObject:card];
}

- (void)checkCardMatchForCards:(Card*)card :(NSMutableArray *)otherCards
{
    int matchScore = [card match:otherCards];
    
    if(matchScore) {
        self.score += matchScore * MATCH_BONUS;
        card.matched = YES;
        // TODO: Set otherCards matched = YES
    } else {
        // Set other cards chosen = NO
        self.score -= MISMATCH_PENALTY;
    }
    
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (instancetype)init
{
    return nil;
}


@end
