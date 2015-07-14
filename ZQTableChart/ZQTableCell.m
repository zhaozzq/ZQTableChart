//
//  ZQTableCell.m
//  ZQTableDome
//
//  Created by zhaozq on 15/3/12.
//  Copyright (c) 2015年 zhaozq. All rights reserved.
//

#import "ZQTableCell.h"

@interface ZQTableCell ()
{
    NSMutableArray *_labelArray;
    
    NSArray *_widths;
    UIColor *_textColor;
    NSTextAlignment  _textAlignment;
    NSDictionary *_dataDict;
    NSArray *_keys;
}
@end

@implementation ZQTableCell

- (void)awakeFromNib {
    // Initialization code
    
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (!_labelArray) {
        _labelArray = [[NSMutableArray alloc] initWithCapacity:0];
        CGFloat origin_x = 0;
        for (NSNumber *width in _widths) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(origin_x, 0, width.floatValue, kTableCellDefaultHeight)];
    
            label.font = [UIFont fontWithName:@"Avenir-Medium" size:10.0];
        
            label.backgroundColor = [UIColor clearColor];
            label.textColor = _textColor;
            label.textAlignment = _textAlignment;
            label.numberOfLines = 2;
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(width.floatValue - 1, 0, 1, label.frame.size.height)];
            line.backgroundColor =  ZQSeparatorGrayColor;
            [label addSubview:line];
            [self.contentView addSubview:label];
            [_labelArray addObject:label];
            
            origin_x += width.floatValue;
        }
        
        UIView *leftLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, kTableCellDefaultHeight)];
        leftLine.backgroundColor = ZQSeparatorGrayColor;
        [self.contentView addSubview:leftLine];
        
        UIView *bottom = [[UIView alloc] initWithFrame:CGRectMake(0, kTableCellDefaultHeight - 1, self.contentView.frame.size.width, 1)];
        bottom.backgroundColor = ZQSeparatorGrayColor;
        [self.contentView addSubview:bottom];
    }
    
    for (NSUInteger i = 0; i < _keys.count; i ++) {
        NSString *key = _keys[i];
        if (i < _labelArray.count) {
            UILabel *label = [_labelArray objectAtIndex:i];
            switch (_textAlignment) {
                case NSTextAlignmentLeft:
                {
                    label.text = [NSString stringWithFormat:@"   %@",_dataDict[key]];
                }
                    break;
                case NSTextAlignmentRight:
                {
                    unichar objectReplacementChar = 0xFFFC;
                    NSString * objectReplacementString = [NSString stringWithCharacters:&objectReplacementChar length:1];
                    label.text = [NSString stringWithFormat:@"%@%@",_dataDict[key],objectReplacementString];
                }
                    break;
                default:
                {
                    label.text = _dataDict[key];
                }
                    break;
            }
            if (label.text.length == 0 || [label.text isEqualToString:@"(null)￼"] ||[label.text isEqualToString:@"￼"]) {
                unichar objectReplacementChar = 0xFFFC;
                NSString * objectReplacementString = [NSString stringWithCharacters:&objectReplacementChar length:1];
                label.text = [NSString stringWithFormat:@"  —%@",objectReplacementString];
            }
        }
    }
    //NSLog(@"%@",_dataDict);
}
- (void)loadViewsWithWidths:(NSArray *)widths textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment
{
    
    _widths = widths;
    _textColor = textColor;
    _textAlignment = textAlignment;
    
}

- (void)setDataValue:(NSDictionary *)dataDict keys:(NSArray *)keys
{
    _dataDict = dataDict;
    _keys = keys;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
