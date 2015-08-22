//
//  DamageTableViewSection.h
//  OSWPicture
//
//  Created by Admin on 6/17/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DamageTableViewSectionDelegate <NSObject>

- (void)didButtonTapped:(int)tagValue;

@end

@interface DamageTableViewSection : UIView

@property (nonatomic) int _tagValue;
@property (nonatomic, weak) id<DamageTableViewSectionDelegate> delegate;

- (void)setButtonTitle:(NSString *)szTitle;

@end
