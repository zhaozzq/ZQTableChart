//
//  UIView+ZQPlus.h
//  MINIBattery
//
//  Created by zhaozq on 14/4/3.
//  Copyright (c) 2014年 zhaozq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZQPlus)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
- (void)addGradientLayerWithColors:(NSArray *)cgColorArray locations:(NSArray *)floatNumArray startPoint:(CGPoint )startPoint endPoint:(CGPoint)endPoint;
@end
