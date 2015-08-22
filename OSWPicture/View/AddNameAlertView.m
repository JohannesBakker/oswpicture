//
//  AddNameAlertView.m
//  kidpower
//
//  Created by Admin on 6/10/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "AddNameAlertView.h"

@implementation AddNameAlertView

- (void)showDialog {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Name required" message:@"Please enter name to add" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField * alertTextField = [alert textFieldAtIndex:0];
    alertTextField.keyboardType = UIAlertViewStyleDefault;
    alertTextField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    alertTextField.placeholder = @"Name";
    [alert show];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        if (self.delegate != nil) {
            [self.delegate clickedCancelButton];
        }
    }
    else if (buttonIndex == 1) {
        if (self.delegate != nil) {
            NSString* newName = [[alertView textFieldAtIndex:0] text];
            [self.delegate clickedOkButton:newName];
        }
    }
    else {
        [self dismissWithClickedButtonIndex:-1 animated:YES];
    }
}

@end
