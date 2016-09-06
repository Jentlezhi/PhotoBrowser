//
//  ViewController.m
//  PhotoBrowserDemo
//
//  Created by Jentle on 16/9/6.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "ViewController.h"
#import "HCWebViewVC.h"
#import "HCTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)webClick:(id)sender {
    
    HCWebViewVC *webVC = [[HCWebViewVC alloc] init];
    [self.navigationController pushViewController:webVC animated:YES];
}
- (IBAction)imageClick:(id)sender {
    
    HCTableViewController *tableVC = [[HCTableViewController alloc] init];
    [self.navigationController pushViewController:tableVC animated:YES];
}


@end
