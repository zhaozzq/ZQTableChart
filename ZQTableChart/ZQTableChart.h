//
//  ZQTableChart.h
//  ZQTableDome
//
//  Created by zhaozq on 15/3/12.
//  Copyright (c) 2015年 zhaozq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZQTableCell.h"

#define ZQBackgroundBlueColor UIColorFromHEX(0xd7ecf6)
#define ZQBackgroundGrayColor UIColorFromHEX(0xedebeb)
#define ZQTextBlueColor  UIColorFromHEX(0x2c83b4)
#define ZQTextBlackColor  [UIColor blackColor]

typedef NS_ENUM(NSInteger, ZQTableScrollStyle) {
    ZQTableScrollRight= 0,//scroll right side only
    ZQTableScrollLeft, //scroll left side only
    ZQTableScrollAll   //scroll both side
};

@protocol ZQTableChartDelegate <NSObject>

@optional
- (void)tableChartHeaderClicked:(NSInteger)tag;

@end


@interface ZQTableChart : UIView <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *leftTitles;
@property (nonatomic, strong) NSArray *rightTitles;

@property (nonatomic, strong) NSArray *leftDataKeys;
@property (nonatomic, strong) NSArray *rightDataKeys;

@property (nonatomic, strong) NSArray *widths;
@property (nonatomic, assign) ZQTableScrollStyle scrollStyle; //TODO: support choose scrollStyle 

@property (nonatomic, assign) id <ZQTableChartDelegate>delegate;
- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray leftTitles:(NSArray *)leftTitles rightTitles:(NSArray *)rightTitles leftKeys:(NSArray *)leftDataKeys rightKeys:(NSArray *)rightDataKeys widths:(NSArray *)widths scrollStyle:(ZQTableScrollStyle)scrollStyle;
@end
