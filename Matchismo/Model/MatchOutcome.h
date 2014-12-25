//
//  MatchOutcome.h
//  Matchismo
//
//  Created by deast on 12/24/14.
//  Copyright (c) 2014 Firebase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Outcome.h"

@interface MatchOutcome : NSObject
@property (nonatomic) Outcome outcome;
@property (nonatomic, strong) NSString *cardContents;

- (instancetype)initWithCards:(NSMutableArray *)cards :(Outcome)outcome;
@end
