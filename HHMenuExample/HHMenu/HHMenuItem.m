//
//  HHMenuItem.m
//  HHMenuExample
//
//  Created by DEMAI on 14-11-12.
//  Copyright (c) 2014年 eric. All rights reserved.
//

#import "HHMenuItem.h"

@implementation HHMenuItem

+(instancetype)itemWithTitle:(NSString *)title preImage:(UIImage *)image
{
    return [[HHMenuItem alloc] init:title image:image];
}

- (id) init:(NSString *) title image:(UIImage *) image
{
    NSParameterAssert(title.length || image);
    self = [super init];
    if (self) {
        _title = title;
        _preImage = image;
    }
    return self;
}
@end
