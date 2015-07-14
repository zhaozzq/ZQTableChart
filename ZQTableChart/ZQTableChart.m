//
//  ZQTableChart.m
//  ZQTableDome
//
//  Created by zhaozq on 15/3/12.
//  Copyright (c) 2015年 zhaozq. All rights reserved.
//

#import "ZQTableChart.h"
#import "UIView+ZQPlus.h"


@interface ZQTableChart ()
{
    UITableView *_leftTableView;
    UITableView *_rightTableView;
    UIScrollView *_leftScrollView;
    UIScrollView *_rightScrollView;
    
    CGFloat _leftWidth;
    CGFloat _rightWidth;
    
    NSUInteger _headerFloors; // Max = 2
    CGFloat _headerHeight;
}
@end

@implementation ZQTableChart

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray leftTitles:(NSArray *)leftTitles rightTitles:(NSArray *)rightTitles leftKeys:(NSArray *)leftDataKeys rightKeys:(NSArray *)rightDataKeys widths:(NSArray *)widths scrollStyle:(ZQTableScrollStyle)scrollStyle
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataArray = dataArray;
        
        _headerFloors = 0;
        self.leftTitles = leftTitles;
        self.rightTitles = rightTitles;
        
        self.leftDataKeys = leftDataKeys;
        self.rightDataKeys = rightDataKeys;
        
        self.widths = widths;
        self.scrollStyle = scrollStyle;
        [self loadTableChart];
        
        self.backgroundColor = [UIColor cyanColor];
    }
    return self;
}

- (void)loadTableChart
{
    CGFloat leftWidth = 0;
    CGFloat rightWidth = 0;
    for (NSNumber *width in [_widths subarrayWithRange:NSMakeRange(0, _leftDataKeys.count)]) {
        leftWidth += width.floatValue;
    }
    _leftWidth = leftWidth;
    for (NSNumber *width in [_widths subarrayWithRange:NSMakeRange(_leftDataKeys.count, _widths.count - _leftDataKeys.count)]) {
        rightWidth += width.floatValue;
    }
    _rightWidth = rightWidth;
    
    
    _leftScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,leftWidth, self.frame.size.height)];
    _leftScrollView.showsHorizontalScrollIndicator = NO;
    _leftScrollView.showsVerticalScrollIndicator = NO;
    _leftScrollView.delegate = self;
    _leftScrollView.contentSize = CGSizeMake(leftWidth, self.frame.size.height);
    _leftScrollView.bounces = NO;
    _leftScrollView.backgroundColor = [UIColor redColor];
    [self addSubview:_leftScrollView];
    
    _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, leftWidth, self.frame.size.height) style:UITableViewStylePlain];
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    _leftTableView.showsHorizontalScrollIndicator = NO;
    _leftTableView.showsVerticalScrollIndicator = NO;
    _leftTableView.bounces = NO;
    _leftTableView.separatorStyle = NO;
    [_leftScrollView addSubview:_leftTableView];
    
    _rightScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(leftWidth, 0, self.frame.size.width - leftWidth, self.frame.size.height)];
    _rightScrollView.showsHorizontalScrollIndicator = NO;
    _rightScrollView.showsVerticalScrollIndicator = NO;
    _rightScrollView.delegate = self;
    _rightScrollView.contentSize = CGSizeMake(rightWidth, self.frame.size.height);
    _rightScrollView.bounces = NO;
    [self addSubview:_rightScrollView];
    
    _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, rightWidth, self.frame.size.height) style:UITableViewStylePlain];
    _rightTableView.delegate = self;
    _rightTableView.dataSource = self;
    _rightTableView.showsHorizontalScrollIndicator = NO;
    _rightTableView.showsVerticalScrollIndicator = NO;
    _rightTableView.bounces = NO;
    _rightTableView.separatorStyle = NO;
    [_rightScrollView addSubview:_rightTableView];
    
    UIView *view0 = [UIView new];
    view0.backgroundColor = [UIColor clearColor];
    _leftTableView.tableFooterView = view0;
    UIView *view1 = [UIView new];
    view1.backgroundColor = [UIColor clearColor];
    _rightTableView.tableFooterView = view1;
}


- (UIView *)headerForTable:(UITableView *)tableView
{
    NSArray *titles = nil;
    CGFloat headerWidth = 0;
    CGFloat origin_x = 0;
    NSArray *widths = nil;
    if ([tableView isEqual:_leftTableView]) {
        titles = _leftTitles;
        headerWidth = _leftWidth;
        widths = [_widths subarrayWithRange:NSMakeRange(0, _leftDataKeys.count)];
    }
    else
    {
        titles = _rightTitles;
        headerWidth = _rightWidth;
        widths = [_widths subarrayWithRange:NSMakeRange(_leftDataKeys.count, _rightDataKeys.count)];
    }
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, headerWidth, _headerHeight)];
    headerView.backgroundColor = ZQBackgroundBlueColor;
    headerView.layer.borderWidth = 1;
    headerView.layer.borderColor = [ZQSeparatorGrayColor CGColor];
    
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < titles.count; i ++) {
        id value = titles[i];
        if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSDictionary class]]) {
            NSNumber *width = widths[j];
            NSString *title = @"";
            BOOL flag = NO;
            if ([value isKindOfClass:[NSDictionary class]]) {
                title = value[@"title"];
                flag = YES;
            }
            else
            {
                title = (NSString *)value;
            }
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(origin_x, 0, width.floatValue, _headerHeight)];
            label.textColor = ZQTextBlueColor;
            if (flag && AtLeastIOS8) //TODO: check
            {
                label.attributedText = [[NSAttributedString alloc] initWithString:title attributes:@{NSUnderlineStyleAttributeName : [NSNumber numberWithInteger:NSUnderlineStyleSingle]}];
            }
            else
            {
                label.text = title;
                if (flag) {
                    label.textColor = [UIColor purpleColor];
                }
            }
            label.font = [UIFont systemFontOfSize:12];
            label.textAlignment = NSTextAlignmentCenter;
            
            label.backgroundColor = [UIColor clearColor];
            label.numberOfLines = 2;
            
            [headerView addSubview:label];
            
            if (flag) {
                label.userInteractionEnabled = YES;
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(2, 2, width.floatValue - 4, _headerHeight - 4);
                [button addTarget:self action:@selector(headerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                button.tag = [(NSNumber *)value[@"tag"] integerValue];
                [label addSubview:button];
            }
            
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(width.floatValue - 1, 0, 1, _headerHeight)];
            line.backgroundColor = ZQSeparatorGrayColor;
            [label addSubview:line];
            
            origin_x += width.floatValue;
            j ++;
        }
        else if ([value isKindOfClass:[NSArray class]])
        {
            NSArray *subTitles = (NSArray *)value;
            
            CGFloat widthSum = 0;
            CGFloat this_x = origin_x;
            for (NSUInteger k = 1; k < subTitles.count; k ++) {
                NSNumber *width = widths[j];
                widthSum += width.floatValue;
                NSString *subTitle = subTitles[k];
                BOOL flag = NO;
                if ([subTitles[k] isKindOfClass:[NSDictionary class]]) {
                    subTitle = subTitles[k][@"title"];
                    flag = YES;
                }
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(origin_x, _headerHeight / 2.0, width.floatValue, _headerHeight/2.0)];
                label.textColor = ZQTextBlueColor;
                if (flag && AtLeastIOS8) //TODO: check
                {
                    label.attributedText = [[NSAttributedString alloc] initWithString:subTitle attributes:@{NSUnderlineStyleAttributeName : [NSNumber numberWithInteger:NSUnderlineStyleSingle]}];
                }
                else
                {
                    label.text = subTitle;
                    if (flag) {
                        label.textColor = [UIColor purpleColor];
                    }
                }

                label.font = [UIFont systemFontOfSize:12];
                label.textAlignment = NSTextAlignmentCenter;
                label.backgroundColor = [UIColor clearColor];
                label.numberOfLines = 2;
                
                [headerView addSubview:label];
                
                if (flag) {
                    label.userInteractionEnabled = YES;
                    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                    button.frame = CGRectMake(2, 2, label.width - 4, label.height - 4);
                    [button addTarget:self action:@selector(headerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                    button.tag = [(NSNumber *)subTitles[k][@"tag"] integerValue];
                    [label addSubview:button];
                }

                
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(width.floatValue - 1, 0, 1, _headerHeight/ 2.0)];
                line.backgroundColor = ZQSeparatorGrayColor;
                [label addSubview:line];
                
                
                origin_x += width.floatValue;
                j ++;
            }
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(this_x, 0, widthSum, _headerHeight / 2.0)];
            label.text = subTitles.firstObject;
            label.font = [UIFont systemFontOfSize:12];
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = [UIColor clearColor];
            label.textColor = ZQTextBlueColor;
            [headerView addSubview:label];
            
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(widthSum - 1, 0, 1, _headerHeight / 2.0)];
            line.backgroundColor = ZQSeparatorGrayColor;
            [label addSubview:line];
            
            UIView *Bline = [[UIView alloc] initWithFrame:CGRectMake(0, _headerHeight / 2.0 - 1, widthSum, 1)];
            Bline.backgroundColor = ZQSeparatorGrayColor;
            [label addSubview:Bline];
        }
        
    }
    return  headerView;
}

#pragma mark - TableView
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (_headerFloors) {
        case 1:
        {
            _headerHeight = 35.0;
            return _headerHeight;
        }
            break;
        case 2:
        {
            _headerHeight = 50.0;
            return  _headerHeight;
        }
            break;

        default:
        {
            return 0;
        }
            break;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self headerForTable:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kTableCellDefaultHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_leftTableView]) {
        static NSString *leftTableCellId = @"leftTableCellId";
        
        ZQTableCell *leftCell = [tableView dequeueReusableCellWithIdentifier:leftTableCellId];
        if (!leftCell) {
            leftCell = [[ZQTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:leftTableCellId];
            [leftCell loadViewsWithWidths:[_widths subarrayWithRange:NSMakeRange(0, _leftDataKeys.count)] textColor:ZQTextBlueColor textAlignment:NSTextAlignmentLeft];
            leftCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [leftCell setDataValue:[_dataArray objectAtIndex:indexPath.row] keys:_leftDataKeys];
        return leftCell;
    }
    else
    {
        static NSString *rightTableCellId = @"rightTableCellId";
        
        ZQTableCell *rightCell = [tableView dequeueReusableCellWithIdentifier:rightTableCellId];
        if (!rightCell) {
            rightCell = [[ZQTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rightTableCellId];
            [rightCell loadViewsWithWidths:[_widths subarrayWithRange:NSMakeRange(_leftDataKeys.count, _rightDataKeys.count)] textColor:ZQTextBlackColor textAlignment:NSTextAlignmentRight];
            rightCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [rightCell setDataValue:[_dataArray objectAtIndex:indexPath.row] keys:_rightDataKeys];
        
        return rightCell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_rightTableView]) {
        if (indexPath.row % 2 == 0)  {
            cell.backgroundColor = ZQBackgroundGrayColor;
        }
        else
        {
            cell.backgroundColor = [UIColor whiteColor];
        }
    }
    else
    {
        cell.backgroundColor = ZQBackgroundBlueColor;
    }
}
#pragma mark - ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ([scrollView isEqual:_leftTableView]) {
        if (_rightTableView) _rightTableView.contentOffset = _leftTableView.contentOffset;
    }
    else if ([scrollView isEqual:_rightTableView])
    {
        if (_leftTableView) _leftTableView.contentOffset = _rightTableView.contentOffset;
    }
}


#pragma mark - setter
- (void)setLeftTitles:(NSArray *)leftTitles
{
    _leftTitles = leftTitles;
    
    if (leftTitles) {
        if (_headerFloors < 1) _headerFloors = 1;
        for (id value in leftTitles) {
            if ([value isKindOfClass:[NSArray class]] && ((NSArray *)value).count > 0) {
                if (_headerFloors < 2) _headerFloors = 2;
                break;
            }
        }
    }
}

- (void)setRightTitles:(NSArray *)rightTitles
{
    _rightTitles = rightTitles;
    
    if (rightTitles) {
        if (_headerFloors < 1) _headerFloors = 1;
        for (id value in rightTitles) {
            if ([value isKindOfClass:[NSArray class]] && ((NSArray *)value).count > 0) {
                if (_headerFloors < 2) _headerFloors = 2;
                break;
            }
        }
    }
 
}

- (void)headerButtonAction:(UIButton *)button
{
    if ([_delegate respondsToSelector:@selector(tableChartHeaderClicked:)])
    {
        [_delegate tableChartHeaderClicked:button.tag];
    }
}
@end
