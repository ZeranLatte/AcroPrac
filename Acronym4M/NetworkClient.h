//
//  NetworkClient.h
//  Acronym4M
//
//  Created by ZZZZeran on 4/16/16.
//  Copyright © 2016 Z Latte. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkClient : NSObject

+ (NetworkClient*)sharedInstance;


typedef void (^CompletionBlock)(NSArray *result, NSError *error);


- (void)getAcronym:(NSString*)acronym completion:(CompletionBlock)completion;

@end
