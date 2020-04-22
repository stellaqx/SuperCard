//
//  PlayingCardView.h
//  SuperCard
//
//  Created by Qian on 4/21/20.
//  Copyright © 2020 Stella Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlayingCardView : UIView

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) BOOL faceup;

- (void)drawRect:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
