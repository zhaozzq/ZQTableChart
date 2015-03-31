//
//  ZQTableChartView.m
//  ZQTableDome
//
//  Created by zhaozq on 15/3/13.
//  Copyright (c) 2015年 zhaozq. All rights reserved.
//

#import "ZQTableChartView.h"
@interface ZQTableChartView () <UIScrollViewDelegate>
{
    ZQTableChart *_tableChart;
}
@end

@implementation ZQTableChartView

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray leftTitles:(NSArray *)leftTitles rightTitles:(NSArray *)rightTitles leftKeys:(NSArray *)leftDataKeys rightKeys:(NSArray *)rightDataKeys widths:(NSArray *)widths delegate:(id<ZQTableChartDelegate>)tableChartDelegate scrollStyle:(ZQTableScrollStyle)scrollStyle
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.bouncesZoom = YES;
        self.maximumZoomScale = 1.5;
        _tableChart = [[ZQTableChart alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) dataArray:dataArray leftTitles:leftTitles rightTitles:rightTitles leftKeys:leftDataKeys rightKeys:rightDataKeys widths:widths scrollStyle:scrollStyle];
        _tableChart.delegate = tableChartDelegate;
        [self addSubview:_tableChart];
        self.contentSize = frame.size;
        
        UITapGestureRecognizer *doubleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleRecognizerAction:)];
        doubleRecognizer.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubleRecognizer];
    }
    return self;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _tableChart;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    //zoomScale
}

- (void)doubleRecognizerAction:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.zoomScale != 1) {
        [self setZoomScale:1.0 animated:YES];
    }
    else
    {
        [self setZoomScale:1.5 animated:YES];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
