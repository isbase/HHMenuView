//
//  HHMenuView.h
//  HHMenuExample
//
//  Created by DEMAI on 14-11-12.
//  Copyright (c) 2014年 Today. All rights reserved.
//
/*
    demo
//初始化数据源
 -(void)getMenuItems
 {
    if (_menuItems && _menuItems.count > 0) return;
    _menuItems = @[[HHMenuItem itemWithTitle:@"扫一扫" preImage:[UIImage imageNamed:@"face.png"]],
    [HHMenuItem itemWithTitle:@"擦擦" preImage:[UIImage imageNamed:@"scan.png"]],
    [HHMenuItem itemWithTitle:@"扫码" preImage:[UIImage imageNamed:@"face"]]];
 }
//按钮点击
 - (IBAction)onButtonClick:(UIButton *)sender {
    [self getMenuItems];
    [HHMenuView showInView:self.view fromRect:sender.frame menuItems:_menuItems withDelegate:self];
 }
 
//实现delegate
 -(void)HHMenuViewSelectIndex:(NSInteger)idx AndTitle:(NSString *)title
 {
    NSLog(@"idx = %d  title : %@",idx,title);
 }
 */

#import <UIKit/UIKit.h>
#import "HHMenuItem.h"

@protocol HHMenuViewDelegate <NSObject>
@optional
-(void)HHMenuViewSelectIndex:(NSInteger)idx AndTitle:(NSString *)title;
@end

@interface HHMenuView : UIView

@property(nonatomic,weak)id<HHMenuViewDelegate> delegate;
- (void)dismisMenuView;     //not't care this


/*
 *  显示HHMenu
 *  @params view  要显示的view
 *  @params rect  点击按钮的位置
 *  @params itmes 数据源 类型为 HHMenuItem 类型数组
 *  @params delegate 实现代理的类
 */
+(void)showInView:(UIView *)view fromRect:(CGRect)rect menuItems:(NSArray *)Items withDelegate:(id<HHMenuViewDelegate>) delegate;

/*
 * 隐藏HHMenu
 */
+(void)dismisHHMenuView;

@end
