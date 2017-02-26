//
//  NSObject+StringController.h
//  textSpeaker
//
//  Created by KaWing on 2/26/17.
//  Copyright © 2017 KaWing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringController: NSObject

@property NSMutableArray *stringList;
@property int start;
@property int end;
@property int size;
@property NSString* result;

-(void)appendString:(NSString*) content;
-(NSString*)removeString;


@end
