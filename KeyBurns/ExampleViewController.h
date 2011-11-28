//
//  ExampleViewController.h
//  KeyBurns
//
//  Created by Javier Berlana on 9/23/11.
//  Copyright 2011 SweetBits.es All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JBKenBurnsView.h"

@interface ExampleViewController : UIViewController {
    JBKenBurnsView *_kenBurnsView;
}

@property (nonatomic, retain) IBOutlet JBKenBurnsView *kenBurnsView;

@end