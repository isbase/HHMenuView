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

@property(nonatomic,retain)NSString *title;
@property(nonatomic,retain)UIImage *preImage;
@property(nonatomic,assign)id target;
@property(nonatomic) SEL action;


- (id) init:(NSString *) title image:(UIImage *) image;

+(instancetype)itemWithTitle:(NSString *)title preImage:(UIImage *)image;


@end
