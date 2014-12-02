//
//  HHMenuItem.m
//  HHMenuExample
//
//  Created by DEMAI on 14-11-12.
//  Copyright (c) 2014年 Today. All rights reserved.
//

#import "HHMenuItem.h"

@implementation HHMenuItem

+(instancetype)itemWithTitle:(NSString *)title preImage:(UIImage *)image
{
    return [[[HHMenuItem alloc] init:title image:image] autorelease];
}

- (id) init:(NSString *) title image:(UIImage *) image
{
    NSParameterAssert(title.length || image);
    self = [super init];
    if (self) {
        self.title = title;
        self.preImage = image;
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
    [_title release];
    [_preImage release];
}
@end
