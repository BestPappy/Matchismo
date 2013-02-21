//
//  Deck.h
//  Matchismo
//
//  Created by Pappy on 2/3/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void)addCard:(Card *)card atTop:(BOOL) atTop;

-(Card *)drawRandomCard;

@end
