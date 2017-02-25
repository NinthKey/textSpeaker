//
//  extractFile.h
//  textSpeaker
//
//  Created by Changyao Huang on 2/25/17.
//  Copyright © 2017 KaWing. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface extractFile : UIViewController {
    NSString *_fileName;
    IBOutlet UITextView *_textView;
}

@property (nonatomic, strong) NSString *fileName;

- (void) extractText;
- (void) displayError: (NSString *) message ;

@end


