//
//  Cell.m
//  CollectionViewLayouts
//
//  Created by Ramon Bartl on 25.05.13.
//  Copyright (c) 2013 Ramon Bartl. All rights reserved.
//

#import "Cell.h"
#import "MLStyle.h"

@implementation Cell

#define labelSize 25

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //NSLog(@"Cell::initWithFrame");
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)setLabelTextTag:(NSInteger)labelTextTag{
    
    self.label = [[UILabel alloc] initWithFrame:CGRectZero];
    self.label.text = [NSString stringWithFormat:@"%ld",(long)labelTextTag];
    self.label.frame = CGRectMake((self.frame.size.width - labelSize)/2, (self.frame.size.height - labelSize)/2, labelSize, labelSize);
    self.label.textColor = [UIColor whiteColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.label];
    
    self.label.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI);
    
//    self.label.backgroundColor = [UIColor brownColor];
}

- (void)drawRect:(CGRect)rect
{
    //// Color Declarations
//    UIColor* fillColor = [UIColor colorWithRed: 0.667 green: 0.667 blue: 0.667 alpha: 1];
    UIColor* fillColor;
    if(self.smored){
        fillColor = kBlueColor;
    }else{
        fillColor = [UIColor colorWithRed: 0.667 green: 0.667 blue: 0.667 alpha: 1];
    }

    //// cell Drawing
    UIBezierPath* cellPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [fillColor setFill];
    [cellPath fill];
}

@end
