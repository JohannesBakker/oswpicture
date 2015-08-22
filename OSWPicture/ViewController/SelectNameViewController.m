//
//  SelectNameViewController.m
//  OSWPicture
//
//  Created by Admin on 6/23/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "SelectNameViewController.h"
#import "OSWPictureDefine.h"
#import "DBManager.h"
#import "OSWPictureName.h"
#import "AddNameAlertView.h"

@interface SelectNameViewController () <UITableViewDataSource, UITableViewDelegate, AddNameAlertViewDelegate> {
    NSMutableArray *arrNames;
    
    AddNameAlertView *alertView;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SelectNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    arrNames = [NSMutableArray array];
    arrNames = [[DBManager sharedInstance] getAllNames];
    [self.tableView reloadData];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTap:)];
    [self.view addGestureRecognizer:tap];
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

#pragma mark - tap gesture
- (void)backgroundTap:(UITapGestureRecognizer *)backgroundTap {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIButton delegate 
- (void)onAddNameClicked {
    alertView = [[AddNameAlertView alloc] init];
    alertView.delegate = self;
    [alertView showDialog];
}

#pragma mark - UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (arrNames.count+1);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)section {
    return (CGFloat)44.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    if (indexPath.row < arrNames.count ) {
        cell = [tableView dequeueReusableCellWithIdentifier:kNameTableViewCell];
        UILabel* label = (UILabel*) [cell viewWithTag:100];
        OSWPictureName *existName = (OSWPictureName *)[arrNames objectAtIndex:indexPath.row];
        [label setText:existName.name];
    } else if (indexPath.row == arrNames.count) {
        cell = [tableView dequeueReusableCellWithIdentifier:kAddNameTableViewCell];
        UIButton* button = (UIButton*) [cell viewWithTag:100];
        [button addTarget:self action:@selector(onAddNameClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < arrNames.count) {
        if (self.delegate != nil) {
            [self dismissViewControllerAnimated:YES completion:^ {
                OSWPictureName *existName = (OSWPictureName *)[arrNames objectAtIndex:indexPath.row];
                [self.delegate didSelectedName:existName.name];
            }];
        }
    }
    
    return;
}

#pragma mark - AddNameAlertView delegate
- (void) clickedOkButton:(NSString *)newName {
    [[DBManager sharedInstance] addName:newName];
    if (self.delegate != nil) {
        [self dismissViewControllerAnimated:YES completion:^{
           [self.delegate didSelectedName:newName]; 
        }];
    }
}

- (void) clickedCancelButton {
    [alertView dismissWithClickedButtonIndex:-1 animated:YES];
}

@end
