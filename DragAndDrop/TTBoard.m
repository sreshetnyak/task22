//
//  TTBoard.m
//  UIViewGeometry
//
//  Created by sergey on 2/9/14.
//  Copyright (c) 2014 sergey. All rights reserved.
//

#import "TTBoard.h"

@interface TTBoard ()
@property (nonatomic,strong) NSMutableArray *whiteCheckers;
@property (nonatomic,strong) NSMutableArray *blackCheckers;

@end

@implementation TTBoard

- (UIView *)initBoardWithSize:(CGRect)rect numberOfCells:(NSUInteger)number {

    if (self = [super init]) {
        self.pointArray = [[NSMutableArray alloc]init];
        self.boardSize = rect.size;
        
        self.whiteCheckers = [[NSMutableArray alloc]init];
        self.blackCheckers = [[NSMutableArray alloc]init];
        
        int width = rect.size.width/number;
        int height = rect.size.height/number;
        int deltaCheckers = 20;
        
        for (int i = 0; i < number; i++) {
            for (int j = 0; j < number; j++) {
                UIImageView *viewImage = [[UIImageView alloc]init];
                UIImageView *checkersImage = [[UIImageView alloc]init];
                UIView *checkersView = [[UIView alloc]init];
                UIView *view = [[UIView alloc]init];
                if (((i % 2) != 0 && (j % 2) == 0) | ((i % 2) == 0 && (j % 2) != 0)) {
                    [view setTag:2];
                    [viewImage setImage:[UIImage imageNamed:@"black.png"]];
                    
                    if (j < 3) {
                        [checkersImage setImage:[UIImage imageNamed:@"black_checkers.png"]];
                        [checkersView setTag:4];
                        
                        [self.blackCheckers addObject:checkersView];
                    }
                    if (j > 4) {
                        [checkersImage setImage:[UIImage imageNamed:@"yellow_checkers.png"]];
                        [checkersView setTag:5];
                        [self.whiteCheckers addObject:checkersView];
                    }
                    
                } else {
                    [view setTag:1];
                    [viewImage setImage:[UIImage imageNamed:@"white.png"]];
                }
                view.frame = CGRectMake(i*width, j*height, width, height);
                if (view.tag == 2) {
                    [self.pointArray addObject:[NSValue valueWithCGRect:view.frame]];
                }
                viewImage.frame = CGRectMake(0, 0, width, height);
                checkersView.frame = CGRectMake(i*width + deltaCheckers/2, j*height + deltaCheckers/2, width - deltaCheckers, height - deltaCheckers);
                checkersImage.frame = CGRectMake(0, 0, width - deltaCheckers, height - deltaCheckers);
                [checkersView addSubview:checkersImage];
                [view addSubview:viewImage];
                [self addSubview:view];
                [self addSubview:checkersView];
            }
        }
        self.backgroundColor = [UIColor clearColor];
        self.frame = rect;
        self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    }
    
    return self;
}

@end
