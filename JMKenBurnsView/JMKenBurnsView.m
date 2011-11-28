//
//  JMKenBurnsView.m
//  KeyBurns
//
//  Created by Javier Berlana on 9/23/11, Modified by Jake Marsh 11/27/11.
//  Copyright 2011 SweetBits.es All rights reserved.
//

#import "JMKenBurnsView.h"
#include <stdlib.h>

#define enlargeRatio 1.2

@interface JMKenBurnsView ()

@property (nonatomic) int currentImage;
@property (nonatomic) BOOL animationInCurse;

- (void) animate:(NSNumber *)num;
- (void) startAnimations:(NSArray *)images;

@end

@implementation JMKenBurnsView

@synthesize imagesArray = _imagesArray;
@synthesize transitionDuration = _transitionDuration;
@synthesize isLoop, isLandscape;
@synthesize animationInCurse, currentImage;

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;

	self.layer.masksToBounds = YES;

    return self;
}
- (void) dealloc {
	[_imagesArray release];

	[super dealloc];
}

- (void) animateWithImages:(NSArray *)images transitionDuration:(float)aTime loop:(BOOL)shouldLoop inLandscape:(BOOL)inLandscape {
    self.imagesArray = images;
    self.transitionDuration = aTime;
    self.isLoop = shouldLoop;
    self.isLandscape = inLandscape;
    self.animationInCurse = NO;

    self.layer.masksToBounds = YES;

    [NSThread detachNewThreadSelector:@selector(startAnimations:) toTarget:self withObject:images];
}

- (void) startAnimations:(NSArray *)images {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    for (uint i = 0; i < [images count]; i++) {
        
        [self performSelectorOnMainThread:@selector(animate:)
                               withObject:[NSNumber numberWithInt:i]
                            waitUntilDone:YES];
        
        sleep(self.transitionDuration);
        i = (i == [images count]-1) && isLoop ? -1 : i; 
    }

    [pool release];
}

- (void) animate:(NSNumber *)num {
    UIImage *image = [self.imagesArray objectAtIndex:[num intValue]];
    UIImageView *imageView;
    
    float resizeRatio   = -1;
    float widthDiff     = -1;
    float heightDiff    = -1;
    float originX       = -1;
    float originY       = -1;
    float zoomInX       = -1;
    float zoomInY       = -1;
    float moveX         = -1;
    float moveY         = -1;
    float frameWidth    = isLandscape ? self.frame.size.width : self.frame.size.height;
    float frameHeight   = isLandscape ? self.frame.size.height : self.frame.size.width;

    // Widder than screen
    if (image.size.width > frameWidth){
        widthDiff = image.size.width - frameWidth;

        // Higher than screen
        if (image.size.height > frameHeight) {
            heightDiff = image.size.height - frameHeight;

            if (widthDiff > heightDiff) 
                resizeRatio = frameHeight / image.size.height;
            else
                resizeRatio = frameWidth / image.size.width;

		// No higher than screen
        } else {
            heightDiff = frameHeight - image.size.height;

            if (widthDiff > heightDiff) 
                resizeRatio = frameWidth / image.size.width;
            else
                resizeRatio = self.bounds.size.height / image.size.height;
        }
    // No widder than screen
    } else {
        widthDiff  = frameWidth - image.size.width;

        // Higher than screen
        if (image.size.height > frameHeight){
            heightDiff = image.size.height - frameHeight;

            if (widthDiff > heightDiff) 
                resizeRatio = image.size.height / frameHeight;
            else
                resizeRatio = frameWidth / image.size.width;

        // No higher than screen
        } else {
            heightDiff = frameHeight - image.size.height;

            if (widthDiff > heightDiff) 
                resizeRatio = frameWidth / image.size.width;
            else
                resizeRatio = frameHeight / image.size.height;
        }
    }

    // Resize the image.
    float optimusWidth  = (image.size.width * resizeRatio) * enlargeRatio;
    float optimusHeight = (image.size.height * resizeRatio) * enlargeRatio;
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, optimusWidth, optimusHeight)];

    // Calcule the maximum move allowed.
    float maxMoveX = optimusWidth - frameWidth;
    float maxMoveY = optimusHeight - frameHeight;

    float rotation = (arc4random() % 9) / 100;

    switch (arc4random() % 4) {
        case 0:
            originX = 0;
            originY = 0;
            zoomInX = 1.25;
            zoomInY = 1.25;
            moveX   = -maxMoveX;
            moveY   = -maxMoveY;
            break;

        case 1:
            originX = 0;
            originY = frameHeight - optimusHeight;
            zoomInX = 1.10;
            zoomInY = 1.10;
            moveX   = -maxMoveX;
            moveY   = maxMoveY;
            break;

        case 2:
            originX = frameWidth - optimusWidth;
            originY = 0;
            zoomInX = 1.30;
            zoomInY = 1.30;
            moveX   = maxMoveX;
            moveY   = -maxMoveY;
            break; 

        case 3:
            originX = frameWidth - optimusWidth;
            originY = frameHeight - optimusHeight;
            zoomInX = 1.20;
            zoomInY = 1.20;
            moveX   = maxMoveX;
            moveY   = maxMoveY;
            break; 

        default:
            NSLog(@"def");
            break;
    }

    CALayer *picLayer = [CALayer layer];

    picLayer.contents = (id)image.CGImage;
    picLayer.anchorPoint = CGPointMake(0, 0); 
    picLayer.bounds = CGRectMake(0, 0, optimusWidth, optimusHeight);
    picLayer.position =  CGPointMake(originX, originY);

    [imageView.layer addSublayer:picLayer];

    CATransition *animation = [CATransition animation];

    [animation setDuration:1];
    [animation setType:kCATransitionFade];
    [[self layer] addAnimation:animation forKey:nil];

    // Remove the previous view
    if ([[self subviews] count] > 0) {
        [[[self subviews] objectAtIndex:0] removeFromSuperview];
    }

    [self addSubview:imageView];

    // Generates the animation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:self.transitionDuration + 1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];

    CGAffineTransform rotate    = CGAffineTransformMakeRotation(rotation);
    CGAffineTransform moveRight = CGAffineTransformMakeTranslation(moveX, moveY);
    CGAffineTransform combo1    = CGAffineTransformConcat(rotate, moveRight);
    CGAffineTransform zoomIn    = CGAffineTransformMakeScale(zoomInX, zoomInY);
    CGAffineTransform transform = CGAffineTransformConcat(zoomIn, combo1);
    imageView.transform = transform;
    [UIView commitAnimations];

    [imageView release];    
}

@end