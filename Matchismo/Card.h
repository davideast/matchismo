//
//  Card.h
//  Matchismo
//
//  Created by deast on 12/14/14.
//  Copyright (c) 2014 Firebase. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter=isChosen) BOOL choosen;
@property (nonatomic, getter=isMatched) BOOL match;

- (int) match:(NSArray *)otherCards;

@end