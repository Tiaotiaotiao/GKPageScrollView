//
//  GKPageMainDisabledViewController.m
//  ObjcExample
//
//  Created by gaokun on 2021/7/19.
//

#import "GKPageMainDisabledViewController.h"
#import <GKPageScrollView/GKPageScrollView.h>
#import <JXCategoryViewExt/JXCategoryView.h>
#import "GKBaseListViewController.h"

@interface GKPageMainDisabledViewController ()<GKPageScrollViewDelegate>

@property (nonatomic, strong) GKPageScrollView *pageScrollView;

@property (nonatomic, strong) UIImageView *headerView;

@property (nonatomic, strong) JXCategoryTitleView *titleView;

@end

@implementation GKPageMainDisabledViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.gk_navBarAlpha = 0;
    self.gk_navTitle = @"禁止主页滑动";
    self.gk_navTitleColor = UIColor.whiteColor;
    self.gk_statusBarStyle = UIStatusBarStyleLightContent;
    
    [self.view addSubview:self.pageScrollView];
    [self.pageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    self.titleView.listContainer = (id<JXCategoryViewListContainer>)self.pageScrollView.listContainerView;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.pageScrollView reloadData];
    });
}

#pragma mark - GKPageScrollViewDelegate
- (UIView *)headerViewInPageScrollView:(GKPageScrollView *)pageScrollView {
    return self.headerView;
}

- (UIView *)segmentedViewInPageScrollView:(GKPageScrollView *)pageScrollView {
    return self.titleView;
}

- (NSInteger)numberOfListsInPageScrollView:(GKPageScrollView *)pageScrollView {
    return self.titleView.titles.count;
}

- (id<GKPageListViewDelegate>)pageScrollView:(GKPageScrollView *)pageScrollView initListAtIndex:(NSInteger)index {
    GKBaseListViewController *listVC = [[GKBaseListViewController alloc] initWithListType:index];
    listVC.shouldLoadData = YES;
    return listVC;
}

#pragma mark - 懒加载
- (GKPageScrollView *)pageScrollView {
    if (!_pageScrollView) {
        _pageScrollView = [[GKPageScrollView alloc] initWithDelegate:self];
        _pageScrollView.mainScrollDisabled = YES;
        _pageScrollView.lazyLoadList = YES;
    }
    return _pageScrollView;
}

- (UIImageView *)headerView {
    if (!_headerView) {
        _headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, ADAPTATIONRATIO * 400)];
        _headerView.image = [UIImage imageNamed:@"test"];
    }
    return _headerView;
}

- (JXCategoryTitleView *)titleView {
    if (!_titleView) {
        _titleView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kBaseSegmentHeight)];
        _titleView.titles = @[@"UITableView", @"UICollectionView", @"UIScrollView"];
    }
    return _titleView;
}

@end
