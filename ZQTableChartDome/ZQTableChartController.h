//
//  ZQTableChartController.h
//  QDNSHNEW
//
//  Created by zhaozq on 15/3/17.
//  Copyright (c) 2015年 QDNSHNEW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZQTableChartView.h"
//#import "TableHeader.h"
//#import "ZQDataParseDelegete.h"

//@protocol ZQTableDataParseDelegete <NSObject>
//
//@optional
//- (void)parseDataWithInfoBody:(NSDictionary *)bodyDict;
//
//@end

@interface ZQTableChartController : UIViewController <ZQTableChartDelegate>
//@property (nonatomic, assign) id<ZQDataParseDelegete> delegete;
@property (nonatomic, strong) ZQTableChartView *tableChart;
//@property (nonatomic, strong) TableHeader *header;
//- (void)requestTableInfoWithParames:(NSDictionary *)parames;
- (void)configTableChartWithDataArray:(NSArray *)dataArr infoPlist:(NSString *)plist scrollStyle:(ZQTableScrollStyle)scrollStyle;
@end
