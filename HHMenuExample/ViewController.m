//
//  ViewController.m
//  HHMenuExample
//
//  Created by DEMAI on 14-11-12.
//  Copyright (c) 2014年 Today. All rights reserved.
//

#import "ViewController.h"
#import "HHMenuView.h"
@interface ViewController ()<HHMenuViewDelegate>

@property(nonatomic,retain)NSArray * menuItems;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    UIButton *button= [[UIButton alloc] initWithFrame:CGRectMake(width - 50, 20, 44, 44)];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"按钮" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button release];
    
    self.menuItems = [NSArray arrayWithObjects:[HHMenuItem itemWithTitle:@"扫一扫" preImage:[UIImage imageNamed:@"face.png"]],
                  [HHMenuItem itemWithTitle:@"擦擦" preImage:[UIImage imageNamed:@"scan.png"]],
                  [HHMenuItem itemWithTitle:@"扫码" preImage:[UIImage imageNamed:@"face"]], nil];
}

- (IBAction)onButtonClick:(UIButton *)sender {
    [HHMenuView showInView:self.view fromRect:sender.frame menuItems:_menuItems withDelegate:self];
}

//delegate
-(void)HHMenuViewSelectIndex:(NSInteger)idx AndTitle:(NSString *)title
{
    NSLog(@"idx = %d  title : %@",idx,title);
}

@end
