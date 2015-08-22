//
//  CameraOverlayView.m
//  OSWPicture
//
//  Created by Admin on 6/11/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "CameraOverlayView.h"

@implementation CameraOverlayView

- (id)init {
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"CameraOverlay" owner:self options:nil] lastObject];
        self.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)onMenuClicked:(id)sender {
    if (self.delegate) {
        [self.delegate didMenuTapped];
    }
}

- (IBAction)onShutterClicked:(id)sender {
    if (self.delegate) {
        [self.delegate didShutterTapped];
    }
}

- (IBAction)onSelectImageClicked:(id)sender {
    if (self.delegate) {
        [self.delegate didSelectImageTapped];
    }
}

@end
