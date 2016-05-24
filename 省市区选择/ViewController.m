//
//  ViewController.m
//  省市区选择
//
//  Created by 杨晓婧 on 16/5/20.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ViewController.h"
#import "SZXSelectProvinceView.h"
@interface ViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,SZXSelectProvinceViewDelegate>{
    NSInteger _provinceIndex;
    NSInteger _cityIndex;
    NSInteger _regionIndex;
}
@property (nonatomic,copy) NSArray *provinceArray;
@property (nonatomic,strong) UIPickerView *pickerView;

@end

@implementation ViewController

-(NSArray *)provinceArray{
    if (!_provinceArray) {
        _provinceArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Province.plist" ofType:nil]];
    }
    return _provinceArray;
}

- (void)viewDidLoad {
    self.textfield.adjustsFontSizeToFitWidth = YES;
    SZXSelectProvinceView *keyBoardView = [SZXSelectProvinceView selectProvinceView];
    //
    keyBoardView.selectDelegate = self;
    [[self.textfield valueForKey:@"textInputTraits"] setValue:[UIColor clearColor] forKey:@"insertionPointColor"];
    self.textfield.inputView = keyBoardView;
    self.pickerView =  keyBoardView.provincePickerView;
    self.pickerView.delegate = self;
    [self refreshPickerView:self.pickerView];
}

-(void)btnClickSelect:(SZXSelectProvinceView *)view andBtn:(UIBarButtonItem *)button{
    if (button.tag == 10) {
        self.textfield.text = [NSString stringWithFormat:@"%@  %@  %@",self.provinceArray[_provinceIndex][@"province"],[self.provinceArray[_provinceIndex][@"citys"]objectAtIndex:_cityIndex][@"city"],[self.provinceArray[_provinceIndex][@"citys"]objectAtIndex:_cityIndex][@"districts"][_regionIndex]];
    }
    [self.textfield resignFirstResponder];
}

- (void)refreshPickerView:(UIPickerView *)pickView{
    [pickView selectRow:_provinceIndex inComponent:0 animated:YES];
    [pickView selectRow:_cityIndex inComponent:1 animated:YES];
    [pickView selectRow:_regionIndex inComponent:2 animated:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return self.provinceArray.count;
    }else if(component == 1){
        return [self.provinceArray[_provinceIndex][@"citys"] count];
    }else if(component == 2){
        NSArray *array = [self.provinceArray[_provinceIndex] objectForKey:@"citys"];
        return [[array[_cityIndex] objectForKey:@"districts"] count];
    }
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *lbl = (UILabel *)view;
    if (lbl == nil) {
        lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width/3, 30)];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.adjustsFontSizeToFitWidth = YES;
        lbl.font = [UIFont systemFontOfSize:16];
    }
    if (component == 0){
        lbl.text =  self.provinceArray [row][@"province"];
    }else if (component == 1){
        NSArray *array = [self.provinceArray[_provinceIndex] objectForKey:@"citys"];
        lbl.text =  [array[row] objectForKey:@"city"];
    }else{
        NSArray *array = [self.provinceArray[_provinceIndex] objectForKey:@"citys"];
        lbl.text =  [[array[_cityIndex] objectForKey:@"districts"] objectAtIndex:row];
    }
    return lbl;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return self.view.bounds.size.width/3-10;
}

//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    if (component == 0){
//        return  self.provinceArray [row][@"province"];
//    }else if (component == 1){
//        NSArray *array = [self.provinceArray[_provinceIndex] objectForKey:@"citys"];
//        return [array[row] objectForKey:@"city"];
//    }else{
//        NSArray *array = [self.provinceArray[_provinceIndex] objectForKey:@"citys"];
//        return [[array[_cityIndex] objectForKey:@"districts"] objectAtIndex:row];
//    }
//}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        _provinceIndex = row;
        _cityIndex = 0;
        _regionIndex = 0;
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        
    }else if (component ==1){
        _cityIndex = row;
        _regionIndex = 0;
        [pickerView reloadComponent:2];
        
    }else{
        _regionIndex = row;
    }
    [self refreshPickerView:pickerView];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
