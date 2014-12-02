//
//  HHMenuView.m
//  HHMenuExample
//
//  Created by DEMAI on 14-11-12.
//  Copyright (c) 2014年 Today. All rights reserved.
//

#import "HHMenuView.h"


@interface HHMenuOverlay : UIView           //空白层
@end

@implementation HHMenuOverlay

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        
        UITapGestureRecognizer *gestureRecognizer;
        gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                    action:@selector(singleTap:)];
        [self addGestureRecognizer:gestureRecognizer];
        [gestureRecognizer release];
    }
    return self;
}

- (void)singleTap:(UITapGestureRecognizer *)recognizer
{
    for (UIView *v in self.subviews) {
        if ([v isKindOfClass:[HHMenuView class]] && [v respondsToSelector:@selector(dismisMenuView)]) {
            [v performSelector:@selector(dismisMenuView)];
        }
    }
}

@end


const CGFloat kArrowSize = 12.f;
const CGFloat kContentWidth = 109.0f;
const CGFloat itemHeight = 37.5f;

@implementation HHMenuView{
    UIView      *_contentView;
    NSArray     *_menuItmes;
    CGFloat     _arrowPosition;
    CGPoint     _arrowPoint;
}

+ (HHMenuView *) instanceMenu
{
    static HHMenuView *shareInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;

}

+(void)showInView:(UIView *)view fromRect:(CGRect)rect menuItems:(NSArray *)Items withDelegate:(id<HHMenuViewDelegate>)delegate
{
    [HHMenuView instanceMenu].delegate = nil;
    [HHMenuView instanceMenu].delegate = delegate;
    [[HHMenuView instanceMenu] showMenuInView:view fromRect:rect menuItems:Items];
}

+(void)dismisHHMenuView
{
    [[HHMenuView instanceMenu] dismisMenuView];
}

- (id)init
{
    self = [super initWithFrame:CGRectZero];
    if(self) {
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowOffset = CGSizeMake(2, 2);
        self.layer.shadowRadius = 1;
    }
    
    return self;
}


- (void) drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self drawBackground:self.bounds
               inContext:UIGraphicsGetCurrentContext()];
}

- (void)drawBackground:(CGRect)frame
             inContext:(CGContextRef) context
{
   [[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8f] set];
    
    CGFloat X0 = frame.origin.x;
    CGFloat X1 = frame.origin.x + frame.size.width;
    CGFloat Y0 = frame.origin.y;
    CGFloat Y1 = frame.origin.y + frame.size.height;
    
    // render arrow
    UIBezierPath *arrowPath = [UIBezierPath bezierPath];
    // fix the issue with gap of arrow's base if on the edge
    const CGFloat kEmbedFix = 3.0f;
    const CGFloat arrowXM = CGRectGetWidth(_contentView.frame) * 0.65;
    const CGFloat arrowX0 = arrowXM - kArrowSize;
    const CGFloat arrowX1 = arrowXM + kArrowSize;
    const CGFloat arrowY0 = Y0;
    const CGFloat arrowY1 = Y0 + kArrowSize + kEmbedFix;
    
    [arrowPath moveToPoint:    (CGPoint){arrowXM + 10, arrowY0}];
    [arrowPath addLineToPoint: (CGPoint){arrowX1 + 10, arrowY1}];
    [arrowPath addLineToPoint: (CGPoint){arrowX0 + 10, arrowY1}];
    [arrowPath addLineToPoint: (CGPoint){arrowXM + 10, arrowY0}];
    
    Y0 += kArrowSize;
    [arrowPath fill];
    // render body
    const CGRect bodyFrame = {X0, Y0 + 3, X1 - X0, Y1 - Y0-3};
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithRoundedRect:bodyFrame
                                                          cornerRadius:8];
    [borderPath fill];
}

- (void)showMenuInView:(UIView *)view
              fromRect:(CGRect)rect
             menuItems:(NSArray *)menuItems
{
    _menuItmes = menuItems;
    _contentView = [self createContentView];
    [self addSubview:_contentView];
    
    _arrowPosition = rect.origin.x - CGRectGetWidth(_contentView.frame) * 0.6;
    
    self.frame = (CGRect){CGPointMake(_arrowPosition, rect.origin.y + rect.size.height),_contentView.frame.size};
    _arrowPoint = CGPointMake(self.frame.origin.x + _contentView.frame.size.width, self.frame.origin.y);
    HHMenuOverlay *overlay = [[HHMenuOverlay alloc] initWithFrame:view.bounds];
    [overlay addSubview:self];
    [view addSubview:overlay];
    [overlay release];
    
    
    _contentView.hidden = YES;
    const CGRect toFrame = self.frame;
    self.frame = (CGRect){_arrowPoint, 1, 1};
    [UIView animateWithDuration:0.2
                     animations:^(void) {
                         self.alpha = 1.0f;
                         self.frame = toFrame;
                     } completion:^(BOOL completed) {
                         _contentView.hidden = NO;
                     }];
    
}


-(void)dismisMenuView
{
    self.delegate = nil;
    if (self.superview) {
        
        _contentView.hidden = YES;
        const CGRect toFrame = (CGRect){_arrowPoint, 1, 1};
        [UIView animateWithDuration:0.2
                         animations:^(void) {
                             
                             self.alpha = 0;
                             self.frame = toFrame;
                             
                         } completion:^(BOOL finished) {
                             
                             if ([self.superview isKindOfClass:[HHMenuOverlay class]])
                                 [self.superview removeFromSuperview];
                             [self removeFromSuperview];
                         }];
        
    }

}

- (UIView *) createContentView
{
    for (UIView *v in self.subviews) {
        [v removeFromSuperview];
    }
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, kContentWidth, 10)];
    contentView.backgroundColor = [UIColor clearColor];
    for (int i = 0 ; i < _menuItmes.count ; i++) {
        HHMenuItem *item = _menuItmes[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 5 + i * itemHeight, kContentWidth, itemHeight);
        [button setTitle:item.title forState:UIControlStateNormal];
        button.tag = i;
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
        [button setTitleColor:[UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button addTarget:self action:@selector(onItemClick:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:button];
        UIImageView *preImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 25, 25)];
        preImageView.image = item.preImage;
        [button addSubview:preImageView];
        if (i > 0) {
            UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kContentWidth - 20, 1)];
            lineImage.backgroundColor = [UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1];
            [button addSubview:lineImage];
            [lineImage release];
        }
        
        [preImageView release];
    }
    
    contentView.frame = CGRectMake(10, 10, kContentWidth,itemHeight * _menuItmes.count + 15);
    return [contentView autorelease];
}

-(void)onItemClick:(UIButton *)button
{
    if (_delegate && [_delegate respondsToSelector:@selector(HHMenuViewSelectIndex:AndTitle:)]) {
        [_delegate HHMenuViewSelectIndex:button.tag AndTitle:button.titleLabel.text];
    }
    [self dismisMenuView];
}

@end
