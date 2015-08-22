//
//  ViewController.m
//  OSWPicture
//
//  Created by Admin on 6/11/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "CameraViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "DamageTableViewHeader.h"
#import "DamageTableViewSection.h"
#import "MarkView.h"
#import "AddOSWPictureViewController.h"
#import "DBManager.h"
#import "OSWPictureDefine.h"
#import "SelectNameViewController.h"

@interface CameraViewController () <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate, DamageTableViewSectionDelegate, SelectNameViewControllerDelegate> {
    BOOL isCameraVisible;
    BOOL isUseCamera;
    
    NSMutableArray *arrSections;
    NSMutableArray *arrDatas;
    NSInteger selectedSection;
    
    NSMutableArray *arrMarkView;
}

@property (weak, nonatomic) IBOutlet UIView *viewInit;
@property (weak, nonatomic) IBOutlet UIView *viewMain;
@property (weak, nonatomic) IBOutlet UIImageView *ivBackground;
@property (weak, nonatomic) IBOutlet UIButton *btnShutter;
@property (weak, nonatomic) IBOutlet UIButton *btnMenu;
@property (weak, nonatomic) IBOutlet UIButton *btnHamburger;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraitLeftMarginOfTableView;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    selectedSection = -1;
    
    arrMarkView = [NSMutableArray array];
    arrSections = [[NSMutableArray alloc] initWithObjects:@"Foundation", @"Materials", @"Dryrot", @"Rust",  @"Pest", @"Mold", @"Cracking", @"Safety", @"Furnace", nil];
    arrDatas = [[NSMutableArray alloc] initWithObjects:
                [[NSMutableArray alloc] initWithObjects:@"Basement", @"Crawl", @"Slab", nil],
                [[NSMutableArray alloc] initWithObjects:@"Block", @"Clay", @"Brick", @"Poured", @"Stone", nil],
                [[NSMutableArray alloc] initWithObjects:@"Brown", @"White", @"Soft", @"Weakened", @"Destroy", @"Rotten", @"Ruin", @"Hidden", @"Risky", @"Deteriorated", nil],
                [[NSMutableArray alloc] initWithObjects:@"Redish Brown", @"Corrosion", @"Pitting", @"Flacking", @"Crusting", @"Oxidizing", @"Decay", @"Weakened", @"Attached", @"Hidden", nil],
                [[NSMutableArray alloc] initWithObjects:@"Nested", @"Infestation", @"Dropping", @"Source", @"Eating", @"Trapped", @"Crevices", @"Hidden", @"Active", nil],
                [[NSMutableArray alloc] initWithObjects:@"Growth", @"Spores", @"Living", @"Active", @"Spreading", @"Decay", @"Ruin", @"Airborne", @"Hidden", @"Harmful", nil],
                [[NSMutableArray alloc] initWithObjects:@"Step-down", @"Horizontal", @"Vertical", @"Movement", @"Pressure", @"Forced", @"Shifting", @"Freeze & Thaw Cycle", @"Erosion", @"Weakened", nil],
                [[NSMutableArray alloc] initWithObjects:@"Unsafe", @"Hazard", @"Risky", @"Caution", @"Shock", @"Danger", @"Unplug", @"Warning", @"Disinfect", @"Clean", nil],
                [[NSMutableArray alloc] initWithObjects:@"Electric", @"Forced Air", @"Oil", @"Stream", @"Filter", @"Vents", nil],
                nil];
    
    self.tableView.tableHeaderView = [[DamageTableViewHeader alloc] init];
    self.constraitLeftMarginOfTableView.constant = -320.0f;
    [self.tableView addGestureRecognizer:[self panGestureRecognizer]];
    
    isCameraVisible = YES;
    isUseCamera = YES;
    
    [self setViewVisible];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (isCameraVisible) {
        if (isUseCamera) {
            [self takePhoto];
        }
        else {
            [self selectPhoto];
        }
    }
    else {
        self.btnHamburger.hidden = NO;
        self.btnMenu.hidden = NO;
        self.btnShutter.hidden = NO;
    }
}

- (void)setViewVisible {
    if (isCameraVisible) {
        self.viewInit.hidden = NO;
        self.viewMain.hidden = YES;
    }
    else {
        self.viewInit.hidden = YES;
        self.viewMain.hidden = NO;
    }
}

- (void)takePhoto {
    isUseCamera = YES;
    
    self.cameraOverlay = [[CameraOverlayView alloc] init];
    self.cameraOverlay.delegate = self;
    
    self.pickController = [[UIImagePickerController alloc] init];
    self.pickController.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.pickController.showsCameraControls = NO;
    self.pickController.navigationBarHidden = YES;
    self.pickController.toolbarHidden = YES;
    self.pickController.delegate = self;
    self.pickController.modalPresentationStyle = UIModalPresentationFullScreen;
    self.pickController.cameraOverlayView = self.cameraOverlay;

    [self presentModalViewController:self.pickController animated:NO];
}

- (void)selectPhoto {
    self.pickController = [[UIImagePickerController alloc] init];
    self.pickController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    self.pickController.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:
                                      UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    self.pickController.allowsEditing = NO;
    self.pickController.modalPresentationStyle = UIModalPresentationCurrentContext;
    self.pickController.delegate = self;
    
    [self presentModalViewController:self.pickController animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didMenuTapped {
}

- (void)didShutterTapped {
    [self.pickController takePicture];
}

- (void)didSelectImageTapped {
    isUseCamera = NO;
    
    if (self.pickController) {
        [self.pickController dismissViewControllerAnimated:NO completion:^{
            self.pickController = nil;
        }];
    }
    
    [self selectPhoto];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)takenImage editingInfo:(NSDictionary *)editingInfo {
    ;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    self.ivBackground.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    arrMarkView = [NSMutableArray array];
    isCameraVisible = NO;
    [self setViewVisible];
    
    [picker dismissViewControllerAnimated:NO completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:NO completion:nil];
    isCameraVisible = YES;
    isUseCamera = YES;
    selectedSection = -1;
    [self takePhoto];
}

#pragma tag button delegate
- (IBAction)onMenuClicked:(id)sender {
    SelectNameViewController *controller = (SelectNameViewController *)[[UIStoryboard storyboardWithName:kMainStoryboardName bundle:nil] instantiateViewControllerWithIdentifier:kSelectNameVC];
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)onShutterClicked:(id)sender {
    isCameraVisible = YES;
    isUseCamera = YES;
    selectedSection = -1;
    self.constraitLeftMarginOfTableView.constant = -320.0f;
    if ([arrMarkView count] > 0) {
        for (MarkView *oldMark in arrMarkView) {
            [oldMark removeFromSuperview];
        }
    }
    [self.view layoutIfNeeded];
    
    [self takePhoto];
}

- (IBAction)onHamburgerClicked:(id)sender {
    self.tableView.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.constraitLeftMarginOfTableView.constant = 0.0f;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
    }];
}

#pragma tag table view delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [arrSections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (selectedSection == section) {
        return [[arrDatas objectAtIndex:section] count];
    }
    
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section >= arrSections.count) {
        return @"";
    }
    else {
        return [arrSections objectAtIndex:section];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return (CGFloat)75.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)section
{
    return (CGFloat)60.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    DamageTableViewSection *aView = [[DamageTableViewSection alloc] init];
    aView.delegate = self;
    aView._tagValue = (int)section;
    aView.delegate = self;
    [aView setButtonTitle:[arrSections objectAtIndex:section]];
    
    return aView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if (selectedSection == indexPath.section) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"damageTableViewCell"];
        UILabel* label = (UILabel*) [cell viewWithTag:100];
        NSMutableArray *arrSectionDatas = (NSMutableArray *)[arrDatas objectAtIndex:selectedSection];
        [label setText:[arrSectionDatas objectAtIndex:indexPath.row]];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *szTitle = [arrSections objectAtIndex:indexPath.section];
    NSMutableArray *arrTem = [arrDatas objectAtIndex:indexPath.section];
    NSString *szContent = [arrTem objectAtIndex:indexPath.row];
    
    MarkView *newMark = [[MarkView alloc] init];
    [newMark bindMark:szTitle content:szContent];
    
    float fX = ([[UIScreen mainScreen] bounds].size.width - kMarkViewWidth) / 2;
    float fY = ([[UIScreen mainScreen] bounds].size.height - kMarkViewHeight) / 2;
    newMark.frame = CGRectMake(fX, fY, kMarkViewWidth, kMarkViewHeight);
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [newMark setUserInteractionEnabled:YES];
    [newMark addGestureRecognizer:panGesture];
    [self.view setUserInteractionEnabled:YES];
    
    [self.view addSubview:newMark];
    [self.view layoutIfNeeded];
    
    [arrMarkView addObject:newMark];
}

#pragma tag damagetableviewsection delegate
- (void)didButtonTapped:(int)tagValue {
    selectedSection = tagValue;
    
    [self.tableView reloadData];
}

#pragma mark - UIGestureRecognizer delegate
- (UISwipeGestureRecognizer *)panGestureRecognizer {
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    recognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    recognizer.delegate = self;
    
    return recognizer;
}
- (void)handleSwipe:(UISwipeGestureRecognizer *)sender {
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        if (self.tableView.hidden == NO) {
            [UIView animateWithDuration:0.3 animations:^{
                self.constraitLeftMarginOfTableView.constant = -320.0f;
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                self.tableView.hidden = YES;
            }];
        }
    }
}

#pragma mark - UIPanGestureRecognizer delegate 
- (IBAction)handlePanGesture:(UIPanGestureRecognizer *)sender {
    UIGestureRecognizerState state = [sender state];
    
    if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged)
    {
        CGPoint translation = [sender translationInView:self.view];
        [sender.view setTransform:CGAffineTransformTranslate(sender.view.transform, translation.x, translation.y)];
        [sender setTranslation:CGPointZero inView:sender.view];
    }
}

#pragma mark - SelectNameViewController delegate
- (void)didSelectedName:(NSString *)newName {
    AddOSWPictureViewController *controller = (AddOSWPictureViewController *)[[UIStoryboard storyboardWithName:kMainStoryboardName bundle:nil] instantiateViewControllerWithIdentifier:kAddOSWPictureVC];

    if (self.tableView.hidden == NO) {
        self.tableView.hidden = YES;
    }
    self.btnMenu.hidden = YES;
    self.btnShutter.hidden = YES;
    self.btnHamburger.hidden = YES;

    UIGraphicsBeginImageContext(CGSizeMake(self.view.frame.size.width, self.view.frame.size.height));
    [self.view drawViewHierarchyInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    controller.imgPhoto = image;
    controller.name = newName;

    [self presentViewController:controller animated:YES completion:nil];
}

@end
