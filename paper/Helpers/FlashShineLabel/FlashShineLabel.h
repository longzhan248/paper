//
//  FlashShineLabel.h
//  paper
//
//  Created by 詹龙 on 2018/9/26.
//  Copyright © 2018 longzhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlashShineLabel : UILabel

/**
 *  Fade in text animation duration. Defaults to 2.5.
 */
@property (assign, nonatomic, readwrite) CFTimeInterval shineDuration;

/**
 *  Fade out duration. Defaults to 2.5.
 */
@property (assign, nonatomic, readwrite) CFTimeInterval fadeoutDuration;


/**
 *  Auto start the animation. Defaults to NO.
 */
@property (assign, nonatomic, readwrite, getter = isAutoStart) BOOL autoStart;

/**
 *  Check if the animation is finished
 */
@property (assign, nonatomic, readonly, getter = isShining) BOOL shining;

/**
 *  Check if visible
 */
@property (assign, nonatomic, readonly, getter = isVisible) BOOL visible;

/**
 *  Start the animation
 */
- (void)shine;
- (void)shineWithCompletion:(void (^)())completion;
- (void)fadeOut;
- (void)fadeOutWithCompletion:(void (^)())completion;

@end
