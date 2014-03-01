//
//  TTViewController.m
//  DragAndDrop
//
//  Created by sergey on 2/22/14.
//  Copyright (c) 2014 sergey. All rights reserved.
//

#import "TTViewController.h"
#import "TTBoard.h"

@interface TTViewController ()

@property (weak,nonatomic) TTBoard *boardChekers;
@property (weak, nonatomic) UIView* dragView;
@property (assign, nonatomic) CGPoint touchOffset;
@property (assign,nonatomic) CGRect originalPoint;

@end

@implementation TTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    Уровень супермен (остальных уровней не будет)
//    
//    1. Создайте шахматное поле (8х8), используйте черные сабвьюхи
//    2. Добавьте балые и красные шашки на черные клетки (используйте начальное расположение в шашках)
//    3. Реализуйте механизм драг'н'дроп подобно тому, что я сделал в примере, но с условиями:
//    4. Шашки должны ставать в центр черных клеток.
//    5. Даже если я отпустил шашку над центром белой клетки - она должна переместиться в центр ближайшей к отпусканию черной клетки.
//    6. Шашки не могут становиться друг на друга
//    7. Шашки не могут быть поставлены за пределы поля.

    TTBoard  *board = [[TTBoard alloc]initBoardWithSize:CGRectMake(0, 128, 768, 768) numberOfCells:8];
    
    self.boardChekers = board;
    if (board) {
        [self.view addSubview:board];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch* touch = [touches anyObject];
    
    CGPoint pointViewBoard = [touch locationInView:self.boardChekers];
    
    UIView* view = (UIImageView *)[self.boardChekers hitTest:pointViewBoard withEvent:event];
    
    if (![view isEqual:self.boardChekers] && view.tag != 2 && view.tag != 1) {
        
        self.dragView = view;
        self.originalPoint = view.frame;
        
        [self.boardChekers bringSubviewToFront:self.dragView];
        
        CGPoint touchPoint = [touch locationInView:self.dragView];
        
        self.touchOffset = CGPointMake(CGRectGetMidX(self.dragView.bounds) - touchPoint.x,
                                       CGRectGetMidY(self.dragView.bounds) - touchPoint.y);
        
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.dragView.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
                             self.dragView.alpha = 0.3f;
                         }];
        
    } else {
        
        self.dragView = nil;
        
    }
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (self.dragView) {
        
        UITouch* touch = [touches anyObject];
        
        CGPoint pointViewBoard = [touch locationInView:self.boardChekers];

        if (self.boardChekers.boardSize.width > pointViewBoard.x && self.boardChekers.boardSize.height > pointViewBoard.y && pointViewBoard.y > 0 && pointViewBoard.x > 0) {
            
            CGPoint correction = CGPointMake(pointViewBoard.x + self.touchOffset.x,pointViewBoard.y + self.touchOffset.y);
            
            self.dragView.center = correction;
        } else {
            
            [self onTouchesEnded:touches withEvent:event];
        }

    }
    
}

- (void) onTouchesEnded:(NSSet *)touch withEvent:(UIEvent *)event {
    
    UITouch* touches = [touch anyObject];
    
    CGPoint pointViewBoard = [touches locationInView:self.boardChekers];
    
    NSArray *sortedArray;
    sortedArray = [self.boardChekers.pointArray sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        CGRect first = [a CGRectValue];
        CGRect second = [b CGRectValue];
        
        CGFloat firstLenght = [self lengthWithRect:first point:pointViewBoard];
        CGFloat secondLenght = [self lengthWithRect:second point:pointViewBoard];
        
        if (firstLenght < secondLenght) {
            return NSOrderedAscending;
        } else if (firstLenght > secondLenght) {
            return NSOrderedDescending;
        } else {
            return NSOrderedSame;
        }
        
    }];
    
    BOOL isEmpty = YES;
    
    for (UIImageView *view in self.boardChekers.checkersArray) {
        
        if (![view isEqual:self.dragView] && CGRectContainsPoint(view.frame, pointViewBoard) && view.tag != 0) {
            [UIView animateWithDuration:0.3
                             animations:^{
                                 self.dragView.transform = CGAffineTransformIdentity;
                                 self.dragView.alpha = 1.f;
                                 self.dragView.frame = self.originalPoint;
                             }];
            isEmpty = NO;
            break;
        }
    }
    
    if (isEmpty) {
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.dragView.transform = CGAffineTransformIdentity;
                             self.dragView.alpha = 1.f;
                             self.dragView.center = CGPointMake(CGRectGetMidX([[sortedArray objectAtIndex:0] CGRectValue]), CGRectGetMidY([[sortedArray objectAtIndex:0] CGRectValue]));
                         }];
    }
    
    self.dragView = nil;
}



- (CGFloat)lengthWithRect:(CGRect)rect point:(CGPoint)point {

    return sqrtf(pow((CGRectGetMidX(rect) - point.x),2) + pow((CGRectGetMidY(rect) - point.y),2));
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self onTouchesEnded:touches withEvent:event];
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self onTouchesEnded:touches withEvent:event];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
