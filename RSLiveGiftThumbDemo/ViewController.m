//
//  ViewController.m
//  RSLiveGiftThumbDemo
//
//  Created by WhatsXie on 2017/9/4.
//  Copyright © 2017年 StevenXie. All rights reserved.
//

#import "ViewController.h"

#import "NHHeader.h"
#import "NHCarViews.h"
#import "NHPlaneViews.h"

#define NHBounds [UIScreen mainScreen].bounds.size

@interface ViewController ()
@property (nonatomic, weak) NHPresentFlower *flower;
//@property (weak, nonatomic) IBOutlet UIButton *carButton;
//@property (weak, nonatomic) IBOutlet UIButton *planeButton;
//@property (weak, nonatomic) IBOutlet UIButton *bombButton;
//@property (weak, nonatomic) IBOutlet UIButton *flowerButton;
@property (weak, nonatomic) IBOutlet UIButton *thumbButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)carAction:(id)sender {
    
    NHCarViews *car = [NHCarViews loadCarViewWithPoint:CGPointZero];
    NSMutableArray *pointArrs = [[NSMutableArray alloc] init];
    CGFloat width = [UIScreen mainScreen].bounds.size.width / 2;
    [pointArrs addObject:NSStringFromCGRect(CGRectMake(width, 300, width, 300))];
    car.curveControlAndEndPoints = pointArrs;
    [car addAnimationsMoveToPoint:CGPointMake(0, 100) endPoint:CGPointMake(self.view.bounds.size.width +166, 500)];
    [self.view addSubview:car];
    
}
- (IBAction)planeAction:(id)sender {
    NHPlaneViews *plane = [NHPlaneViews loadPlaneViewWithPoint:CGPointMake(NHBounds.width + 232, 0)];
    [plane addAnimationsMoveToPoint:CGPointMake(NHBounds.width, 100) endPoint:CGPointMake(-500, 410)];
    [self.view addSubview:plane];
}
- (IBAction)bombAction:(id)sender {
    NHFighterView *fighter = [NHFighterView loadFighterViewWithPoint:CGPointMake(10, 100)];
    [fighter addAnimationsMoveToPoint:CGPointMake(self.view.bounds.size.width, 60) endPoint:CGPointMake( -500, 600)];
    [self.view addSubview:fighter];
}
// （可累加）鲜花数
- (IBAction)flowerAction:(id)sender {
    if (_flower == nil) {
        [self addFlowerView];
    }else{
        _flower.effect = NHSendEffectSpring;
        [_flower continuePresentFlowers];
    }
}
- (void)addFlowerView{
    NHPresentFlower *flower = [[NHPresentFlower alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 50)presentFlowerEffect:NHSendEffectShake];
    flower.autoHiddenTime = 5;
    [self.view addSubview:flower];
    _flower = flower;
}

- (IBAction)thumbUpAction:(id)sender {
    [self setThumbImageView];
}

- (void)setThumbImageView {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(self.thumbButton.frame.origin.x , self.thumbButton.frame.origin.y - 35, 35, 35);
    imageView.image = [UIImage imageNamed:@"heart"];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.clipsToBounds = YES;
    [self.view addSubview:imageView];
    
//    CGFloat startX = round(random() % 200);
    CGFloat scale = round(random() % 2) + 1.0;
    CGFloat speed = 1 / round(random() % 900) + 0.6;
    int imageName = round(random() % 12);
    
    [UIView beginAnimations:nil context:(__bridge void *_Nullable)(imageView)];
    [UIView setAnimationDuration:7 * speed];
    
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"resource.bundle/heart%d.png",imageName]];
    //    imageView.frame = CGRectMake(NHBounds.width - startX, -100, 35 * scale, 35 * scale);
    imageView.frame = CGRectMake(self.thumbButton.frame.origin.x, 0, 35 * scale, 35 * scale);
    
    
    [UIView setAnimationDidStopSelector:@selector(onAnimationComplete:finished:context:)];
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}

- (void)onAnimationComplete:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context{
    UIImageView *imageView = (__bridge UIImageView *)(context);
    [imageView removeFromSuperview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
