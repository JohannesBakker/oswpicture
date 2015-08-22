//
//  DamageTableViewHeader.m
//  OSWPicture
//
//  Created by Admin on 6/17/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "DamageTableViewHeader.h"

@implementation DamageTableViewHeader

- (id)init {
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"DamageTableViewHeader" owner:self options:nil] lastObject];
        self.frame = CGRectMake(0, 0, 320, 66);
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

@end
