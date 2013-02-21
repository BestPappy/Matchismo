//
//  Card.h
//  Matchismo
//
//  Created by Pappy on 2/3/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter=isFaceUp) BOOL faceUp;

@property (nonatomic, getter=isUnplayable) BOOL unplayable;

//@property (nonatomic, readonly) BOOL matchWasTested;

//@property (strong, nonatomic, readonly) NSMutableArray *otherCardsTested;

- (int)match:(NSArray *)otherCards;

@end
