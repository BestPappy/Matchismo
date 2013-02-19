//
//  Card.m
//  Matchismo
//
//  Created by Pappy on 2/3/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "Card.h"

//@interface Card()
//@property (nonatomic, readwrite) BOOL matchWasTested;
//@property (strong, nonatomic, readwrite) NSMutableArray *otherCardsTested;
//@end

@implementation Card
/*
- (NSMutableArray *) otherCardsTested {
    if (!_otherCardsTested) _otherCardsTested = [[NSMutableArray alloc]init];
    return _otherCardsTested;
}
*/

-(int)match:(NSArray *)otherCards
{
    int score = 0;
//    self.matchWasTested=NO;
//    [self.otherCardsTested removeAllObjects];
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score += 1;
        }
    }
    
//    self.matchWasTested=YES;
//    [self.otherCardsTested addObjectsFromArray:otherCards];
//    [self.otherCardsTested addObject:self];
    return score;
}

@end
