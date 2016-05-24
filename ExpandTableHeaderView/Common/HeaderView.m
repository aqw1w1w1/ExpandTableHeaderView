//
//  HeaderView.m
//  ExpandTableHeaderView
//
//  Created by bingyu on 16/5/24.
//  Copyright © 2016年 AVIC. All rights reserved.
//

#import "HeaderView.h"

#define ScrollContentOffset                     @"contentOffset"
#define OtherViewHeight                         50.0
#define FooterViewHeight                        44.0

@interface HeaderView ()

@property (strong, nonatomic) UIScrollView *tableScrollView;//tableView对应的ScrollView
@property (strong, nonatomic) UIImageView *bgImageView;     //背景图片
@property (assign, nonatomic) CGFloat headerViewHeight;      //当前view的高度

@property (strong, nonatomic) UIView *otherView;
@property (strong, nonatomic) UIView *footerContainerView;

@end

@implementation HeaderView

#pragma mark - 初始化

/**
 *  初始化方法
 *
 *  @param frame     自身位置、大小
 *  @param tableView 父容器
 *
 *  @return 实例化后的HeaderView
 */
- (instancetype)initWithFrame:(CGRect)frame withTableView:(UITableView *)tableView {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.userInteractionEnabled = YES;
        _tableScrollView = tableView;
        _headerViewHeight = frame.size.height;
        
        [self initView:frame];
        [self addOtherView];
        [self addFooterView];
    }
    
    return self;
}

/**
 *  初始化UI
 *
 *  @param rect 当前view的frame
 */
- (void)initView:(CGRect)rect {
    _tableScrollView.contentInset = UIEdgeInsetsMake(_headerViewHeight, 0, 0, 0);
    
    //初始化背景图片(因为设置了contentInset，如果_bgImageView要从原点开始则要重新设置Y坐标)
    _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -_headerViewHeight, rect.size.width, rect.size.height)];
    _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    _bgImageView.clipsToBounds = YES;
    _bgImageView.image = [UIImage imageNamed:@"T-ara.jpg"];
    _bgImageView.userInteractionEnabled = YES;
    
    [_tableScrollView insertSubview:_bgImageView atIndex:0];
    
    //添加scrollview属性（contentOffset）监听
    [_tableScrollView addObserver:self forKeyPath:ScrollContentOffset options:NSKeyValueObservingOptionNew context:nil];
}

/**
 *  添加头像、昵称等的容器
 */
- (void)addOtherView {
    CGRect rect = CGRectMake(0, _bgImageView.frame.size.height - FooterViewHeight - OtherViewHeight - 10, _bgImageView.frame.size.width, OtherViewHeight);
    _otherView = [[UIView alloc] initWithFrame:rect];
    _otherView.backgroundColor = [UIColor clearColor];
    [_bgImageView addSubview:_otherView];
    
    CGFloat headerImageWidth = OtherViewHeight;
    UIImageView *headerImage = [[UIImageView alloc] initWithFrame:CGRectMake((_otherView.frame.size.width - headerImageWidth) / 2, 0, headerImageWidth, headerImageWidth)];
    headerImage.layer.cornerRadius = headerImageWidth / 2;
    headerImage.layer.masksToBounds = YES;
    headerImage.image = [UIImage imageNamed:@"伊利丹.jpg"];
    [_otherView addSubview:headerImage];
}

/**
 *  添加底部容器view
 */
- (void)addFooterView {
    CGRect rect = CGRectMake(0, self.frame.size.height - FooterViewHeight, self.frame.size.width, FooterViewHeight);
    rect.origin.y = rect.origin.y - _headerViewHeight;         // 调整坐标位置，对应上移-200个像素
    _footerContainerView = [[UIView alloc] initWithFrame:rect];
    _footerContainerView.backgroundColor = [UIColor redColor];
    
    [_tableScrollView addSubview:_footerContainerView];
}

#pragma mark - NSKeyValueObserving

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:ScrollContentOffset]) {
        [self scrollViewDidScroll:_tableScrollView];
    }
}

#pragma mark - 私有方法

- (void)scrollViewDidScroll:(UIScrollView*)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if(offsetY < _headerViewHeight * -1) {
        CGRect currentFrame = _bgImageView.frame;
        currentFrame.origin.y = offsetY;
        currentFrame.size.height = -1 * offsetY;
        _bgImageView.frame = currentFrame;
        
        CGRect otherViewFrame = _otherView.frame;
        otherViewFrame.origin.y = _bgImageView.frame.size.height - FooterViewHeight - OtherViewHeight - 10;
        _otherView.frame = otherViewFrame;
    }
}

/**
 *  销毁时把监听取消掉
 */
- (void)dealloc {
    if (_tableScrollView) {
        [_tableScrollView removeObserver:self forKeyPath:ScrollContentOffset];
        _tableScrollView = nil;
    }
    
    _bgImageView = nil;
}

@end
