//
//  ExampleViewController.h
//  KeyBurns
//
//  Created by Javier Berlana on 9/23/11.
//  Copyright 2011 SweetBits.es All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMKenBurnsView.h"

@interface ExampleViewController : UIViewController {
    JMKenBurnsView *keyView;
}

@property (nonatomic, retain) IBOutlet JMKenBurnsView *keyView;

@end
