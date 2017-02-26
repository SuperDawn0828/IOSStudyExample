//
//  Transition ViewController.m
//  IOSStudyExample
//
//  Created by 黎明 on 16/10/9.
//  Copyright © 2016年 黎明. All rights reserved.
//

#import "TransitionViewController.h"

static NSString *kCATransitionShowImage = @"kCATransitionShowImage";

@interface TransitionViewController ()
@property (nonatomic,strong) UIImageView *showImageView;
@property (nonatomic,strong) NSArray *imageNames;
@property (nonatomic,assign) int currentPalce;
@property (nonatomic,assign) int imageCount;

@end

@implementation TransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageNames = @[@"show_image_00",
                        @"show_image_01",
                        @"show_image_02",
                        @"show_image_03",
                        @"show_image_04"];
    self.currentPalce = 0;
    self.imageCount = (int)self.imageNames.count;
    [self setupSubviews];
}

- (void)setupSubviews
{
    self.showImageView = [[UIImageView alloc] init];
    self.showImageView.bounds = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.showImageView.center = CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0);
    self.showImageView.userInteractionEnabled = YES;
    self.showImageView.image = [UIImage imageNamed:self.imageNames[self.currentPalce]];
    [self.view addSubview:self.showImageView];
    
    UISwipeGestureRecognizer *leftSwipeGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGRAction:)];
    leftSwipeGR.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.showImageView addGestureRecognizer:leftSwipeGR];
    
    UISwipeGestureRecognizer *rightSwipeGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGRAction:)];
    rightSwipeGR.direction = UISwipeGestureRecognizerDirectionRight;
    [self.showImageView addGestureRecognizer:rightSwipeGR];
}

- (void)createTransiton
{
    
}

- (void)swipeGRAction:(UISwipeGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        self.currentPalce--;
        [self isNextImagePalce:YES];
    }
    
    if (gestureRecognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        self.currentPalce++;
        [self isNextImagePalce:NO];
    }
}

- (void)isNextImagePalce:(BOOL)next
{
    if (self.currentPalce < 0) {
        self.currentPalce = self.imageCount - 1;
    }
    
    if (self.currentPalce >= self.imageCount) {
        self.currentPalce = 0;
    }
    
    CATransition *transition = [[CATransition alloc] init];
    transition.type = kCATransitionMoveIn;
    transition.subtype = next?kCATransitionFromRight:kCATransitionFromLeft;
//    transition.duration = 0.6;
    self.showImageView.image = [UIImage imageNamed:self.imageNames[self.currentPalce]];
    [self.showImageView.layer addAnimation:transition forKey:kCATransitionShowImage];
}

@end
