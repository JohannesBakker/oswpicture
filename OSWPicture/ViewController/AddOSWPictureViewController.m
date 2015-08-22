//
//  AddOSWPictureViewController.m
//  OSWPicture
//
//  Created by Admin on 6/22/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "AddOSWPictureViewController.h"

@interface AddOSWPictureViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *ivPhoto;
@end

@implementation AddOSWPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.ivPhoto.image = self.imgPhoto;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark button click delegate
- (IBAction)onBackClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onShareClicked:(id)sender {
}

@end
