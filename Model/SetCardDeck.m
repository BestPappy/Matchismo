//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Pappy on 2/15/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (id)init {
    self = [super init];
    
    // A deck of "set" cards always starts out with 81 cards, one card for every combination of attributes.
    if (self) {
        for (int number = 1; number <= [SetCard maxNumber]; number++) {
            for (NSString *shading in [SetCard validShadings]) {
                for (NSString *color in [SetCard validColors]) {
                    for (NSString *symbol in [SetCard validSymbols]) {
                        SetCard *setCard = [[SetCard alloc] init];
                        setCard.number = number;
                        setCard.shading = shading;
                        setCard.color = color;
                        setCard.symbol = symbol;
                        [self addCard:setCard atTop:NO];
                    }
                }
            }
        }
    }
    
    return self;
}


@end
