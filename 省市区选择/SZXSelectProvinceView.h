//
//  SZXSelectProvinceView.h
//  省市区选择
//
//  Created by 杨晓婧 on 16/5/20.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SZXSelectProvinceView;
@protocol SZXSelectProvinceViewDelegate <NSObject>

@optional
- (void)btnClickSelect:(SZXSelectProvinceView *)view andBtn:(UIBarButtonItem *)button;

@end

@interface SZXSelectProvinceView : UIView
@property (weak, nonatomic) IBOutlet UIPickerView *provincePickerView;
@property (nonatomic,weak) id <SZXSelectProvinceViewDelegate> selectDelegate;
- (IBAction)doneBtnClicked:(id)sender;

+ (instancetype)selectProvinceView;

@end
