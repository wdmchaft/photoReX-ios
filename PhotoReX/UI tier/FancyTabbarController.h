//
//  FancyTabbarController.h
//  photoReX
//
//  Created by Ali Nouri on 12/21/11.
//  Copyright (c) 2011 Rutgers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FancyTabbar.h"


@interface FancyTabbarController : UIViewController
{
    NSMutableArray* viewControllers;    //array of UIViewController
    NSMutableArray* autoHideArray;      //array of BOOL (does each page need the tabbar to autohide when selected) 
    
    int selectedIndex;                  //the index of the current selected page 
    int previousSelectedIndex;         //the index of the previous page (-1 means N/A)
    
    BOOL _isShowing;                 //are we showing the tabbar 
    FancyTabbar* tabbar; 
}

-(void) setupGestures; 
-(void) setupViewControllers; 
-(void) selectedItemDidChange:(int) selectedIndex; 
-(void) gotoPreviousPage; 

-(void) showBarWithAnimation:(BOOL) animation; 
-(void) hideBarWithAnimation:(BOOL) animation; 
-(void) changeTabbarAppearanceWithAnimation:(BOOL)animation toShow:(BOOL)show;      //this is auxiliary method

-(void) handleTabbarGesture:(UISwipeGestureRecognizer *)gestureRecognizer; 

@property (readonly) BOOL isShowing; 
@property (readonly) UIViewController* selectedViewController; 

+(FancyTabbarController*) getInstance;        //the singleton pattern (we never have two tabbars, right?) 

@end
