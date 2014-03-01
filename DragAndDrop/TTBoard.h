//
//  TTBoard.h
//  UIViewGeometry
//
//  Created by sergey on 2/9/14.
//  Copyright (c) 2014 sergey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTBoard : UIView

@property (assign,nonatomic) CGSize boardSize;
@property (strong,nonatomic) NSMutableArray *pointArray;
@property (nonatomic,strong) NSMutableArray *checkersArray;

- (UIView *)initBoardWithSize:(CGRect)rect numberOfCells:(NSUInteger)number;

@end
