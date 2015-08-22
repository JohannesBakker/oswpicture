//
//  MarkView.m
//  OSWPicture
//
//  Created by Admin on 6/18/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "MarkView.h"

@interface MarkView ()

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;

@end

@implementation MarkView

- (id)init {
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"MarkView" owner:self options:nil] lastObject];
        self.frame = CGRectMake(0, 0, kMarkViewWidth, kMarkViewHeight);
    }
    
    return self;
}

- (void)bindMark:(NSString *)title content:(NSString *)content {
    self.lblTitle.text = title;
    self.lblContent.text = content;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
