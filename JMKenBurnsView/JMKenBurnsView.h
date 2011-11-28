//
//  JMKenBurnsView.h
//  KeyBurns
//
//  Created by Javier Berlana on 9/23/11, Modified by Jake Marsh 11/27/11.
//  Copyright 2011 SweetBits.es All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface JMKenBurnsView : UIView {
    NSArray *_imagesArray;

    float _transitionDuration;
    BOOL _isLoop;
    BOOL _isLandscape;
}

@property (nonatomic, retain) NSArray *imagesArray;
@property (nonatomic, assign) float transitionDuration;
@property (nonatomic) BOOL isLoop;
@property (nonatomic) BOOL isLandscape;

- (void) animateWithImages:(NSArray *)images transitionDuration:(float)time loop:(BOOL)isLoop inLandscape:(BOOL)isLandscape;

@end