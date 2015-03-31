//
//  ZQTableChartController.m
//  QDNSHNEW
//
//  Created by zhaozq on 15/3/17.
//  Copyright (c) 2015年 QDNSHNEW. All rights reserved.
//

#import "ZQTableChartController.h"
#define kScreenHeight     [UIScreen mainScreen].bounds.size.height
#define kScreenWidth      [UIScreen mainScreen].bounds.size.width
@interface ZQTableChartController () <ZQTableChartDelegate>

@end

@implementation ZQTableChartController{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@""];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSError *error;
    NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    NSLog(@"%@",error);
    if (dataDict) {
        [self configTableChartWithDataArray:dataDict[@"dataList"] infoPlist:@"BadLoanTable02" scrollStyle:0];  //BadLoanTable  BadLoanTable01 BadLoanTable02
    }

}

- (void)configTableChartWithDataArray:(NSArray *)dataArr infoPlist:(NSString *)plist scrollStyle:(ZQTableScrollStyle)scrollStyle
{
    if (_tableChart) {
        [_tableChart removeFromSuperview];
    }
    
    NSString * path = [[NSBundle mainBundle] pathForResource:plist ofType:@".plist"];
    NSDictionary *data = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSArray *leftTitles = [data objectForKey:@"leftTitles"];
    NSArray *rightTitles = [data objectForKey:@"rightTitles"];
    NSArray *leftKeys = [data objectForKey:@"leftKeys"];
    NSArray *rightKeys = [data objectForKey:@"rightKeys"];
    NSArray *widths = [data objectForKey:@"widths"];
        
    _tableChart = [[ZQTableChartView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight - 20) dataArray:dataArr leftTitles:leftTitles rightTitles:rightTitles leftKeys:leftKeys rightKeys:rightKeys widths:widths delegate:self scrollStyle:scrollStyle];
    _tableChart.tableChartDelegate = self;
    [self.view addSubview:_tableChart];
}

- (void)tableChartHeaderClicked:(NSInteger)tag
{
    NSLog(@"tableChartHeaderClicked  tag:%zd",tag);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
