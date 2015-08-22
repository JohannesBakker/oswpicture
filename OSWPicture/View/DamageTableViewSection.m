//
//  DamageTableViewSection.m
//  OSWPicture
//
//  Created by Admin on 6/17/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "DamageTableViewSection.h"

@interface DamageTableViewSection () {
    ;
}

@property (weak, nonatomic) IBOutlet UIButton *btnTitle;

@end

@implementation DamageTableViewSection

- (id)init {
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"DamageTableViewSection" owner:self options:nil] lastObject];
        self.frame = CGRectMake(0, 0, 320, 75);
    }
    
    return self;
}

- (void)setButtonTitle:(NSString *)szTitle {
    [self.btnTitle setTitle:szTitle forState:UIControlStateNormal];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)onButtonClicked:(id)sender {
    if (self.delegate != nil) {
        [self.delegate didButtonTapped:self._tagValue];
    }
}

@end
