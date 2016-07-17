//
//  TestResultTableViewController.m
//  SUNSearchController
//
//  Created by Michael on 16/6/14.
//  Copyright © 2016年 com.51fanxing.searchController. All rights reserved.
//

#import "TestResultTableViewController.h"
#import "Product.h"
#import "TestDetailViewController.h"
#import "TestResultViewCell.h"
#import "MBProgressHUD+Extension.h"

@interface TestResultTableViewController ()<TestResultViewCellDelegate>

@property (nonatomic, strong) UIMenuController *menuController;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation TestResultTableViewController

#pragma mark - UITableViewDelegate、UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchResults.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestResultViewCell *cell = [TestResultViewCell cellWithTableView:tableView];
    cell.delegate = self;
    
    cell.product = self.searchResults[indexPath.row];

    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    TestDetailViewController *detail = [[TestDetailViewController alloc] init];
    [self.presentingViewController.navigationController pushViewController:detail animated:YES];
}


#pragma mark - TestResultViewCellDelegate
- (void)testResultViewCell:(TestResultViewCell *)testResultViewCell didLongPressRecognizer:(UILongPressGestureRecognizer *)longPressRecognizer
{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.searchResults indexOfObject:testResultViewCell.product] inSection:0];
    
    self.indexPath = indexPath;
    CGRect contentRect = CGRectZero;
    UIButton *contentBtn;
    
    for (UIView *subViews in testResultViewCell.contentView.subviews) {
        for (UIView *subView in subViews.subviews) {
            if ([subView isKindOfClass:[UIButton class]]) {
                
                contentBtn = (UIButton*)subView;
                
                contentRect = subView.frame;
            }
        }
        
    }
    
    [self.menuController setTargetRect:contentRect inView:contentBtn.superview];
    
    [self.menuController setMenuVisible:YES animated:YES];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}


- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(copy:)){
        return YES;
    }else{
        return NO;
    }
}

#pragma mark - Private Method
- (void)copy:(UIMenuItem *)button
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    Product *product = self.searchResults[self.indexPath.row];
    pasteboard.string  = product.name;
    [MBProgressHUD showTipsMessage:@"拷贝成功" toView:self.view];
}

- (void)setSearchResults:(NSMutableArray *)searchResults
{
    _searchResults = searchResults;
    [self.tableView reloadData];
}

#pragma mark - setter and getter
- (UIMenuController *)menuController
{
    if (_menuController == nil) {
        _menuController = [UIMenuController sharedMenuController];
        [_menuController setArrowDirection:(UIMenuControllerArrowDown)];
    }
    return _menuController;
}

@end
