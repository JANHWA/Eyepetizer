//
//  DetailViewController.m
//  Eyepetizer
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 CheeHwa. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImageView+WebCache.h"
#import "KRVideoPlayerController.h"
#import "CollectModel.h"
#import "JHDetailView.h"

@interface DetailViewController ()<KRVideoPlayerControllerProtocol>
{
//    UIImageView *_bgImage;
    UIImageView *_frontImage;
    UIButton *_playButton;
    UILabel *_titleLabel;
    UIView *_lineView;
    UILabel *_cTlabel;
    UILabel *_contentLabel;
    UIView *_bgView;
    
    // 收藏按钮
    UIButton *_collectBtn;
    // 收藏提示
    UILabel *_messageLabel;
}

@property(nonatomic, strong)KRVideoPlayerController *videoController;
@property (strong, nonatomic) JHDetailView *detailView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
    
    [self configUI];
    
    [self customButton:@"back" withLocation:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [_videoController dismiss];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];

}

- (void)loadData
{
    
}

- (void)initView {
    
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    KWS(ws);
    
    [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    // 创建前面的视图
    _frontImage             = [[UIImageView alloc] init];
    [_frontImage sd_setImageWithURL:[NSURL URLWithString:_detailCoverForFeed]];
    [self.view addSubview:_frontImage];
    [_frontImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view.mas_top).offset(64);
        make.left.equalTo(ws.view.mas_left).offset(0);
        make.height.mas_equalTo(kScreenWidth *(9.0/16.0));
        make.right.equalTo(ws.view.mas_right).offset(0);
    }];
    // 创建player按钮
    _playButton = [[UIButton alloc] init];
    [self.view addSubview:_playButton];
    [_playButton setBackgroundImage:[UIImage imageNamed:@"btn_play"] forState:UIControlStateNormal];
    [_playButton addTarget:self action:@selector(playBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_frontImage.mas_centerX);
        make.centerY.equalTo(_frontImage.mas_centerY);
        make.width.mas_equalTo(100);
        make.height.equalTo(_playButton.mas_width);
    }];
    
    // 提示Label
    _messageLabel = [[UILabel alloc] init];
    _messageLabel.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.500];
    _messageLabel.alpha = 0;
    _messageLabel.textAlignment = NSTextAlignmentCenter;
    _messageLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:_messageLabel];
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view.mas_centerX);
        make.bottom.equalTo(ws.view.mas_bottom).offset(-100);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    
}
- (void)configUI
{
    
    NSDictionary *dict = @{
                           @"title":_detailTitle,
                           @"detailCategory":_detailCategory,
                           @"detailDuration":_detailDuration,
                           @"detailCoverBlurred":_detailCoverBlurred,
                           @"detailDescription":_detailDescription
                           };
    
    [self.detailView showContentWithDic:dict];

     if ([CollectModel MR_findByAttribute:@"title" withValue:_detailTitle].count > 0) {
           _collectBtn.selected = YES;
      }
    [self.view bringSubviewToFront:_messageLabel];
}

/**
 *    收藏按钮的方法
 */

- (void)collectBtnClick:(UIButton *)sender
{
    if (sender.selected) {
        // 当前状态是收藏,现在执行取消操作
        CollectModel  *model = [[CollectModel MR_findByAttribute:@"title" withValue:_detailTitle ] firstObject];
        [model MR_deleteEntity];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        [UIView animateWithDuration:1.5 animations:^{
            _messageLabel.text = @"取消收藏";
            _messageLabel.alpha = 1;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1.5 animations:^{
                _messageLabel.alpha = 0;
            }];
        }];
        
    }else{
        // 当前状态没有收藏,现在执行收藏操作
        CollectModel *model = [CollectModel MR_createEntity];
        model.title = _detailTitle;
        model.category = _detailCategory;
        model.duration = [NSString stringWithFormat:@"%@",_detailDuration];
        model.playUrl = _detailPlayUrl;
        model.coverForFeed = _detailCoverForFeed;
        model.my_description = _detailDescription;
        model.coverBlurred = _detailCoverBlurred;
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        [UIView animateWithDuration:1.5 animations:^{
            _messageLabel.text = @"收藏成功";
            _messageLabel.alpha = 1;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1.5 animations:^{
                _messageLabel.alpha = 0;
            }];;
        }];
    }
    sender.selected = !sender.selected;
}

/*
 分享按钮按钮
 */
- (void)shareBtnClick:(UIButton *)sender
{
}

- (void)swipeClick:(UISwipeGestureRecognizer *)sendr
{
//    [_videoController dismiss];
}

// 返回按钮并结束播放
- (void)backBtnClick
{
    [_videoController dismiss];
    [self.navigationController popViewControllerAnimated:YES];
    
}

// 点击播放按钮
- (void)playBtnClick
{
    
    NSURL *url = [NSURL URLWithString:_detailPlayUrl];
    [self playerUrl:url];
}



- (void)playerUrl:(NSURL *)url
{
    if (!self.videoController) {
        _videoController = [[KRVideoPlayerController alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenWidth *(9.0/16.0))];
        _videoController.delegate = self;
        [_videoController setShouldAutoplay:YES];
        [_videoController setFullscreen:YES animated:YES];
        __weak typeof(self) ws = self;
        [_videoController setDimissCompleteBlock:^{
            ws.videoController = nil;
        }];
        [_videoController showInWindow];
    }
    _videoController.contentURL = url;
}

- (void)KRVideoPlayerIsFull:(BOOL)isFull {
    
    if (isFull) {
        // 全屏播放
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        [self.navigationController setNavigationBarHidden:YES];
    } else {
        // 非全屏播放
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        [self.navigationController setNavigationBarHidden:NO];
    }
}

/**
 懒加载

 @return
 */
- (JHDetailView *)detailView {
    
    
    if (_detailView == nil) {
        _detailView = [[JHDetailView alloc] init];
        [self.view addSubview:_detailView];
        KWS(ws);
        _collectBtn = _detailView.collectionBtn;
        _detailView.buttonBlock = ^(UIButton *sender) {
          
            [ws collectBtnClick:sender];
        };
    }
    
    return _detailView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
