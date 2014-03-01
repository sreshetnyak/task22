//
//  TTBoard.m
//  UIViewGeometry
//
//  Created by sergey on 2/9/14.
//  Copyright (c) 2014 sergey. All rights reserved.
//

#import "TTBoard.h"

@interface TTBoard ()

@end

@implementation TTBoard

- (UIView *)initBoardWithSize:(CGRect)rect numberOfCells:(NSUInteger)number {

    if (self = [super init]) {
        
        self.pointArray = [[NSMutableArray alloc]init];
        self.boardSize = rect.size;
        
        self.checkersArray = [[NSMutableArray alloc]init];
        
        int width = rect.size.width/number;
        int height = rect.size.height/number;
        int deltaCheckers = 20;
        
        for (int i = 0; i < number; i++) {
            for (int j = 0; j < number; j++) {
                UIImageView *viewImage = [[UIImageView alloc]init];
                UIImageView *checkersImage = [[UIImageView alloc]init];
                
                if (((i % 2) != 0 && (j % 2) == 0) | ((i % 2) == 0 && (j % 2) != 0)) {
                    [viewImage setImage:[UIImage imageNamed:@"black.png"]];
                    [viewImage setTag:2];
                    if (j < 3) {
                        [checkersImage setImage:[UIImage imageNamed:@"black_checkers.png"]];
                        [checkersImage setTag:5];
                    }
                    if (j > 4) {
                        [checkersImage setImage:[UIImage imageNamed:@"yellow_checkers.png"]];
                        [checkersImage setTag:5];
                    }
                    
                } else {
                    [viewImage setImage:[UIImage imageNamed:@"white.png"]];
                    [viewImage setTag:1];
                }

                viewImage.frame = CGRectMake(i*width, j*height, width, height);
                
                if (viewImage.tag == 2)[self.pointArray addObject:[NSValue valueWithCGRect:viewImage.frame]];
                
                [self.checkersArray addObject:checkersImage];
                
                checkersImage.frame = CGRectMake(i*width + deltaCheckers/2, j*height + deltaCheckers/2, width - deltaCheckers, height - deltaCheckers);
                
                viewImage.userInteractionEnabled = YES;
                checkersImage.userInteractionEnabled = YES;
                [self addSubview:viewImage];
                [self addSubview:checkersImage];
            }
        } 
        self.backgroundColor = [UIColor clearColor];
        self.frame = rect;
        self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    }
    
    return self;
}

@end
