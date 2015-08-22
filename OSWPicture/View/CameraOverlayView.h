//
//  CameraOverlayView.h
//  OSWPicture
//
//  Created by Admin on 6/11/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CameraOverlayView;

@protocol CameraOverlayViewDelegate <NSObject>

- (void)didMenuTapped;
- (void)didShutterTapped;
- (void)didSelectImageTapped;

@end

@interface CameraOverlayView : UIView

@property (nonatomic, weak) id<CameraOverlayViewDelegate> delegate;

@end
