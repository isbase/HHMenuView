//
//  HHMenuItem.h
//  HHMenuExample
//
//  Created by DEMAI on 14-11-12.
//  Copyright (c) 2014年 Today. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HHMenuItem : NSObject

@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)UIImage *preImage;
@property(nonatomic,weak)id target;
@property(nonatomic) SEL action;

+(instancetype)itemWithTitle:(NSString *)title preImage:(UIImage *)image;


@end
