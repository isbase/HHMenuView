//
//  HHMenuView.h
//  HHMenuExample
//
//  Created by DEMAI on 14-11-12.
//  Copyright (c) 2014年 Today. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHMenuItem.h"

@protocol HHMenuViewDelegate <NSObject>
@optional
-(void)HHMenuViewSelectIndex:(NSInteger)idx AndTitle:(NSString *)title;
@end

@interface HHMenuView : UIView

@property(nonatomic,weak)id<HHMenuViewDelegate> delegate;
- (void)dismisMenuView;

+(void)showInView:(UIView *)view fromRect:(CGRect)rect menuItems:(NSArray *)Items withDelegate:(id<HHMenuViewDelegate>) delegate;
+(void)dismisHHMenuView;

@end
