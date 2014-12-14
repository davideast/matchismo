//
//  ViewController.m
//  Matchismo
//
//  Created by deast on 12/14/14.
//  Copyright (c) 2014 Firebase. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"

@interface ViewController ()

@property (nonatomic) int flipCount;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (strong, nonatomic) Deck *deck;

@end

@implementation ViewController

- (Deck *) deck
{
    if(!_deck) _deck = [[PlayingCardDeck alloc] init];
    return _deck;
}

- (void) setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    // Is the card on the front or back?
    if([sender.currentTitle length]) {
        UIImage *cardImage = [UIImage imageNamed:@"cardback"];
        [sender setBackgroundImage:cardImage
                          forState:UIControlStateNormal];
    
        [sender setTitle:@"" forState:UIControlStateNormal];
    } else {
        // draw a card
        Card *drawnCard = [self.deck drawRandomCard];
        UIImage *cardImage = [UIImage imageNamed:@"cardfront"];
        [sender setBackgroundImage:cardImage
                          forState:UIControlStateNormal];
        NSString *cardTitle = @"X"; // set a no card title default
        // if a card exists set the title to its contents
        if(drawnCard) {
            cardTitle = drawnCard.contents;
        }
        [sender setTitle:cardTitle forState:UIControlStateNormal];
    }
    self.flipCount++;
}

@end
