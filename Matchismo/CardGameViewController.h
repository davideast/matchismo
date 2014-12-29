//
//  ViewController.h
//  Matchismo
//
//  Created by deast on 12/14/14.
//  Copyright (c) 2014 Firebase. All rights reserved.
//
// Abstract class

#import <UIKit/UIKit.h>
#import "PlayingCardDeck.h"

@interface CardGameViewController : UIViewController

- (Deck *)createDeck;

@end

