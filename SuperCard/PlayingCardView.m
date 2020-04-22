//
//  PlayingCardView.m
//  SuperCard
//
//  Created by Qian on 4/21/20.
//  Copyright © 2020 Stella Xu. All rights reserved.
//

#import "PlayingCardView.h"

@implementation PlayingCardView


// MARK: -

#define CORNER_FONT_STADNDARD_HGITHT 180.0
#define CORNER_RADIUS 12.0

// helpers for calculating corner scale factor
- (CGFloat)cornerScaleFactor {return self.bounds.size.height/CORNER_FONT_STADNDARD_HGITHT;}

- (CGFloat)cornerRadius {return CORNER_RADIUS * [self cornerScaleFactor];}

- (CGFloat)cornerOffset {return [self cornerRadius] / 3.0; }

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setup];
    }
    
    return self;
}

/*
 Only override drawRect: if you perform custom drawing.
 An empty implementation adversely affects performance during animation. */
- (void)drawRect:(CGRect)rect {
    // UIBezierPath
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    
    [roundedRect addClip]; // clip it
    
    [[UIColor whiteColor] setFill];
    // a C function
    UIRectFill(self.bounds);
    
    // add a stroke
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    
    if (self.faceup) {
        // ui image in center
        NSString *imageName = [NSString stringWithFormat:@"%@%@", [self rankAsString], self.suit];
        UIImage *faceImage = [UIImage imageNamed:imageName];
        NSLog(@"%@", imageName);
        
        if (faceImage) {
            //        CGRect imageRect = CGRectInset(self.bounds, self.bounds.size.width *(1.0 -[self cornerScaleFactor]), self.bounds.size.height *(1.0 -[self cornerScaleFactor]));
            CGRect imageRect = CGRectInset(self.bounds, self.bounds.size.width *0.1, self.bounds.size.height *0.1);
            [faceImage drawInRect:imageRect];
            
        } else {
            [self drawPipes];
        }
        
        // text (rank_suite) in corner
        [self drawCorner];
    } else {
        UIImage *faceImage = [UIImage imageNamed:@"cardback"];
        CGRect imageRect = CGRectInset(self.bounds, self.bounds.size.width *0.1, self.bounds.size.height *0.1);
                   [faceImage drawInRect:imageRect];
    }
    
}

- (void)drawPipes {
    
}

- (void)drawCorner {
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    
    style.alignment = NSTextAlignmentCenter;
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    font = [font fontWithSize:font.pointSize * [self cornerScaleFactor]];
    
    NSAttributedString *cornerText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@", [self rankAsString], self.suit] attributes:@{NSFontAttributeName: font, NSParagraphStyleAttributeName: style}];
    
    CGRect textBound;
    textBound.origin = CGPointMake([self cornerOffset], [self cornerOffset]);
    textBound.size = [cornerText size];
    [cornerText drawInRect:textBound];
    
    // rotate it upside down
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI); // radius rotation, 180 degrees
    [cornerText drawInRect:textBound];
}

- (NSString *)rankAsString{
    NSArray *res = @[@"?", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
    return res[self.rank];
}

// MARK: -

- (void)setup {
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

// MARK: -

- (void)setSuit:(NSString *)suit {
    _suit = suit;
    [self setNeedsDisplay]; // setNeedsDisplay is the trigger drawing for drawRect
}

- (void)setRank:(NSUInteger)rank {
    _rank = rank;
    [self setNeedsDisplay];
}

- (void)setFaceUp:(BOOL)faceup {
    _faceup = faceup;
    [self setNeedsDisplay];
}

@end
