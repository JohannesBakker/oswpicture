//
//  AddNameAlertView.h
//  kidpower
//
//  Created by Admin on 6/10/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddNameAlertView;

@protocol AddNameAlertViewDelegate <NSObject>

- (void) clickedOkButton:(NSString *)newName;
- (void) clickedCancelButton;

@end

@interface AddNameAlertView : UIAlertView

- (void)showDialog;

@end
