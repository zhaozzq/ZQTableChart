//
//  ZQTableChartView.h
//  ZQTableDome
//
//  Created by zhaozq on 15/3/13.
//  Copyright (c) 2015年 zhaozq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZQTableChart.h"

@interface ZQTableChartView : UIScrollView

@property (nonatomic, assign) id<ZQTableChartDelegate> tableChartDelegate;

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray leftTitles:(NSArray *)leftTitles rightTitles:(NSArray *)rightTitles leftKeys:(NSArray *)leftDataKeys rightKeys:(NSArray *)rightDataKeys widths:(NSArray *)widths delegate:(id<ZQTableChartDelegate>)tableChartDelegate scrollStyle:(ZQTableScrollStyle)scrollStyle;

@end
