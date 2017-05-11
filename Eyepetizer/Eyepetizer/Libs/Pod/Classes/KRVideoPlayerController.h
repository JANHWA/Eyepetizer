//
//  KRVideoPlayerController.h
//  KRKit
//
//  Created by aidenluo on 5/23/15.
//  Copyright (c) 2015 36kr. All rights reserved.
//

@import MediaPlayer;

@protocol KRVideoPlayerControllerProtocol <NSObject>


/**
 是否全屏播放

 @param isFull 
 */
- (void)KRVideoPlayerIsFull:(BOOL)isFull;

@end

@interface KRVideoPlayerController : MPMoviePlayerController

@property (nonatomic, copy)void(^dimissCompleteBlock)(void);
@property (nonatomic, assign) CGRect frame;
@property (nonatomic, weak) id <KRVideoPlayerControllerProtocol> delegate;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)showInWindow;
- (void)dismiss;


@end
