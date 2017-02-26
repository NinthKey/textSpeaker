//
//  TETDetailViewController.h
//  TET_iOS
//
//  Created by Friedhelm Brügge on 01.02.12.
//  Copyright (c) 2012 www.bruegge.biz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+StringController.h"

@interface TETDetailViewController : UIViewController <UIActionSheetDelegate> {
    NSString *_fileName;
    IBOutlet UIWebView *_webView;
    IBOutlet UIToolbar *_toolBar;
}

@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) StringController *stringController;

- (IBAction)actionButtonPressed:(id)sender ;



@end
