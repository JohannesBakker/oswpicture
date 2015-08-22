//
//  CameraViewController.h
//  OSWPicture
//
//  Created by Admin on 6/11/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraOverlayView.h"

@interface CameraViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPopoverControllerDelegate, CameraOverlayViewDelegate>

@property (nonatomic, retain) UIImagePickerController *pickController;
@property (nonatomic, retain) CameraOverlayView *cameraOverlay;
@property (nonatomic, retain) UIPopoverController *popController;

@end

