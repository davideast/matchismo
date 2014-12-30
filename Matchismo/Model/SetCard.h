//
//  SetCard.h
//  Matchismo
//
//  Created by deast on 12/30/14.
//  Copyright (c) 2014 Firebase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *shading;
@property (nonatomic) NSUInteger number;

+ (NSArray *)validSymbols;
+ (NSArray *)validColors;
+ (NSArray *)validShadings;
+ (NSUInteger)maxNumber;

@end