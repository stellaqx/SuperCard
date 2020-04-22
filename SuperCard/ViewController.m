//
//  ViewController.m
//  SuperCard
//
//  Created by Qian on 4/21/20.
//  Copyright © 2020 Stella Xu. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet PlayingCardView *playCardView;

@end

@implementation ViewController

- (IBAction)swipe:(UISwipeGestureRecognizer *)sender {
    self.playCardView.faceup = !self.playCardView.faceup;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*
    PlayingCardView *playingCardView = [[PlayingCardView alloc] initWithFrame:CGRectMake(20, 20, 50, 100)];
    [self.view addSubview:playingCardView]; */
    
    self.playCardView.rank = 13;
    self.playCardView.suit = @"♥︎";
    self.playCardView.faceup = YES;
    
}


@end
