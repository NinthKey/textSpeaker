//
//  TETExtractorViewController.h
//  TET_iOS
//
//  Created by Friedhelm Brügge on 01.02.12.
//  Copyright (c) 2012 www.bruegge.biz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+StringController.h"



@interface TETExtractorViewController : UIViewController {
    NSString *_fileName;
    IBOutlet UITextView *_textView;
}

@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) StringController *stringController;

- (void) extractText;
- (void) displayError: (NSString *) message ;

@end
