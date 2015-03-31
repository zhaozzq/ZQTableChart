//
//  ZQTableCell.h
//  ZQTableDome
//
//  Created by zhaozq on 15/3/12.
//  Copyright (c) 2015年 zhaozq. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kTableCellDefaultHeight  30.0f
#define KTableCellDefaultWidth   50.0f
#define  Version_Value  [[[UIDevice currentDevice]systemVersion] floatValue]
#define AtLeastIOS8 (Version_Value >= 8.0)
#define UIColorFromHEX(HEXValue) [UIColor colorWithRed:((float)((HEXValue & 0xFF0000) >> 16))/255.0 green:((float)((HEXValue & 0xFF00) >> 8))/255.0 blue:((float)(HEXValue & 0xFF))/255.0 alpha:1.0]
#define ZQSeparatorGrayColor  UIColorFromHEX(0xbbc1c3)

@interface ZQTableCell : UITableViewCell

- (void)loadViewsWithWidths:(NSArray *)widths textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment;

- (void)setDataValue:(NSDictionary *)dataDict keys:(NSArray *)keys;


@end
