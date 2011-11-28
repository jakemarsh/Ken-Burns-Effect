//
//  ExampleViewController.m
//  KeyBurns
//
//  Created by Javier Berlana on 9/23/11.
//  Copyright 2011 SweetBits.es All rights reserved.
//

#import "ExampleViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation ExampleViewController

@synthesize kenBurnsView = _kenBurnsView;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!self) return nil;

    
	
	return self;
}
- (void) dealloc {
    [super dealloc];
}

#pragma mark - View lifecycle

- (void) viewDidLoad {
    [super viewDidLoad];

    self.kenBurnsView.layer.borderWidth = 1;
    self.kenBurnsView.layer.borderColor = [UIColor blackColor].CGColor;    

    NSArray *slideshowImages = [NSArray arrayWithObjects:
								[UIImage imageNamed:@"image1.jpeg"],
								[UIImage imageNamed:@"image2.jpeg"],
								[UIImage imageNamed:@"image3.jpeg"],
								[UIImage imageNamed:@"image4.png"],
								[UIImage imageNamed:@"image5.png"], nil];

	[self.kenBurnsView animateWithImages:slideshowImages
				 transitionDuration:15.0 
							   loop:YES 
						inLandscape:YES];
}
- (void) viewDidUnload {
    self.kenBurnsView = nil;

    [super viewDidUnload];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

#pragma mark Cleanup

- (void) didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

@end