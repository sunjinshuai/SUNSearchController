//
//  TestTableViewController.m
//  SUNSearchController
//
//  Created by Michael on 16/6/14.
//  Copyright © 2016年 com.51fanxing.searchController. All rights reserved.
//

#import "TestTableViewController.h"
#import "TestResultTableViewController.h"
#import "Product.h"
#import "TestDetailViewController.h"
#import "TestResultViewCell.h"
#import "MBProgressHUD+Extension.h"

@interface TestTableViewController ()<UISearchResultsUpdating, UISearchBarDelegate,TestResultViewCellDelegate>

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSMutableArray *searchResults; // Filtered search results
@property (nonatomic, strong) NSArray *products;
@property (nonatomic, strong) UIMenuController *menuController;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation TestTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"全部品牌";
    
    self.products = [Product allProducts];
    
    TestResultTableViewController *result = [[TestResultTableViewController alloc] init];
    result.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:result];
    
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.placeholder = @"搜索品牌";
    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.definesPresentationContext = YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestResultViewCell *cell = [TestResultViewCell cellWithTableView:tableView];
    cell.delegate = self;
    
    cell.product = self.products[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    TestDetailViewController *detail = [[TestDetailViewController alloc] init];
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchString = [self.searchController.searchBar text];
    
    NSString *scope = nil;
    
    NSInteger selectedScopeButtonIndex = [self.searchController.searchBar selectedScopeButtonIndex];
    if (selectedScopeButtonIndex > 0) {
        scope = [[Product deviceTypeNames] objectAtIndex:(selectedScopeButtonIndex - 1)];
    }
    
    [self updateFilteredContentForProductName:searchString type:scope];
    if (self.searchController.searchResultsController) {
        
        TestResultTableViewController *vc = (TestResultTableViewController *)self.searchController.searchResultsController;
        vc.searchResults = self.searchResults;
        [vc.tableView reloadData];
    }
    
}

#pragma mark - Content Filtering
- (void)updateFilteredContentForProductName:(NSString *)productName type:(NSString *)typeName
{
    if ((productName == nil) || [productName length] == 0) {
        if (typeName == nil) {
            self.searchResults = [self.products mutableCopy];
        } else {
            NSMutableArray *searchResults = [[NSMutableArray alloc] init];
            for (Product *product in self.products) {
                if ([product.type isEqualToString:typeName]) {
                    [searchResults addObject:product];
                }
            }
            self.searchResults = searchResults;
        }
        return;
    }
 
    [self.searchResults removeAllObjects];
    
    for (Product *product in self.products) {
        if ((typeName == nil) || [product.type isEqualToString:typeName]) {
            NSUInteger searchOptions = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch;
            NSRange productNameRange = NSMakeRange(0, product.name.length);
            NSRange foundRange = [product.name rangeOfString:productName options:searchOptions range:productNameRange];
            if (foundRange.length > 0) {
                [self.searchResults addObject:product];
            }
        }
    }
}


#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    [self updateSearchResultsForSearchController:self.searchController];
}

#pragma mark - TestResultViewCellDelegate
- (void)testResultViewCell:(TestResultViewCell *)testResultViewCell didLongPressRecognizer:(UILongPressGestureRecognizer *)longPressRecognizer
{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.products indexOfObject:testResultViewCell.product] inSection:0];
    
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
    Product *product = self.products[self.indexPath.row];
    pasteboard.string  = product.name;
    [MBProgressHUD showTipsMessage:@"拷贝成功" toView:self.view];
}


#pragma mark - Lazy load
- (NSArray *)products
{
    if (!_products) {
        _products = [NSArray array];
    }
    return _products;
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
