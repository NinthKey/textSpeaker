//
//  NSObject+StringController.m
//  textSpeaker
//
//  Created by KaWing on 2/26/17.
//  Copyright © 2017 KaWing. All rights reserved.
//

#import "NSObject+StringController.h"

@implementation StringController

-(instancetype)init
{
    self = [super init];
    if(self){
        self.stringList = [[NSMutableArray alloc] initWithCapacity:200];
        self.start = 0;
        self.end = 0 ;
        self.result = @"";
    }
    
    return self;
}

-(void)appendString:(NSString*) content{
    [self.stringList addObject:content];    self.end += 1;
    self.size = _end - _start;
}

-(NSString*)removeString{
    ;
    if(self.start<self.end){
        _result = [_stringList objectAtIndex:_start];
//        NSLog(result);
        _start += 1;
        self.size = _end - _start; 
    }
    
    return _result;
}


@end
