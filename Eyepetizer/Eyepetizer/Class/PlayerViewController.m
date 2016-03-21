//
//  PlayerViewController.m
//  Eyepetizer
//
//  Created by qianfeng on 16/3/19.
//  Copyright © 2016年 CheeHwa. All rights reserved.
//

#import "PlayerViewController.h"
#import "KRVideoPlayerController.h"
#import "UIImageView+WebCache.h"

@interface PlayerViewController ()

@property(nonatomic, strong)KRVideoPlayerController *videoController;

@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.51 green:0.45 blue:0.45 alpha:1];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [imageView sd_setImageWithURL:[NSURL URLWithString:_imageUrl]];
    [self.view addSubview:imageView];
    [self playerUrl:_url];
    imageView.userInteractionEnabled = YES;
    UISwipeGestureRecognizer *pan = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handelPan:)];
    pan.direction = UISwipeGestureRecognizerDirectionDown;
    [imageView addGestureRecognizer:pan];
}
- (void)handelPan:(UIPanGestureRecognizer *)sender
{
    [_videoController dismiss];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
//            
//            interfaceOrientation == UIInterfaceOrientationLandscapeRight );
//}

- (void)playerUrl:(NSURL *)url
{
    if (!self.videoController) {
        _videoController = [[KRVideoPlayerController alloc] initWithFrame:CGRectMake(0, 200, kScreenWidth, kScreenWidth *(9.0/16.0))];
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
