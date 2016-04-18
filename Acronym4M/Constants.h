//
//  Constants.h
//  Acronym4M
//
//  Created by ZZZZeran on 4/18/16.
//  Copyright © 2016 Z Latte. All rights reserved.
//

#ifdef SYNTHESIZE_CONSTS
# define CONST(name, value) NSString* const name = @ value
#else
# define CONST(name, value) extern NSString* const name
#endif

#import <Foundation/Foundation.h>

CONST(KEY_SF, "sf");
CONST(KEY_LFS, "lfs");
CONST(KEY_LF, "lf");
CONST(KEY_FREQ, "freq");
CONST(KEY_SINCE, "since");
CONST(KEY_VARS, "vars");





@interface Constants : NSObject



@end
