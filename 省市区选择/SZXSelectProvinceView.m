//
//  SZXSelectProvinceView.m
//  省市区选择
//
//  Created by 杨晓婧 on 16/5/20.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "SZXSelectProvinceView.h"

@implementation SZXSelectProvinceView

- (IBAction)doneBtnClicked:(id)sender {
    if ([self.selectDelegate respondsToSelector:@selector(btnClickSelect:andBtn:)]) {
        [self.selectDelegate btnClickSelect:self andBtn:sender];
    }
}

+ (instancetype)selectProvinceView{
    return [[[NSBundle mainBundle] loadNibNamed:@"SZXSelectProvinceView" owner:nil options:nil]lastObject];
}


@end
