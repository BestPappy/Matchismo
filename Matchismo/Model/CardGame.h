//
//  CardGame.h
//  Matchismo
//
//  Created by Pappy on 2/16/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardGame : NSObject

// designated initializer
- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (strong, nonatomic) NSMutableArray *cards;

@property (nonatomic) int score;

@property (nonatomic) NSString *resultMsg;

@property (nonatomic, readonly) BOOL matchWasTested;

@property (strong, nonatomic, readonly) NSMutableArray *cardsTested;


@end
