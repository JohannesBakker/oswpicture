//
//  MarkView.h
//  OSWPicture
//
//  Created by Admin on 6/18/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMarkViewWidth      238
#define kMarkViewHeight     180

@interface MarkView : UIView

- (void)bindMark:(NSString *)title content:(NSString *)content;

@end
