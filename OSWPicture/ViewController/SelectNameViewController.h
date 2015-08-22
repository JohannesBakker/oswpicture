//
//  SelectNameViewController.h
//  OSWPicture
//
//  Created by Admin on 6/23/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SelectNameViewController;

@protocol SelectNameViewControllerDelegate <NSObject>

- (void)didSelectedName:(NSString *)newName;

@end

@interface SelectNameViewController : UIViewController

@property (nonatomic, retain)id<SelectNameViewControllerDelegate> delegate;

@end
