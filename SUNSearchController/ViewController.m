//
//  ViewController.m
//  SUNSearchController
//
//  Created by Michael on 16/6/14.
//  Copyright © 2016年 com.51fanxing.searchController. All rights reserved.
//

#import "ViewController.h"
#import "TestTableViewController.h"

@interface ViewController ()

- (IBAction)click;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"UISearchController的使用";
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)click
{
    TestTableViewController *table = [[TestTableViewController alloc] init];
    table.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.navigationController pushViewController:table animated:YES];
}
@end
