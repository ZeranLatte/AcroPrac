//
//  NetworkClient.m
//  Acronym4M
//
//  Created by ZZZZeran on 4/16/16.
//  Copyright © 2016 Z Latte. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkClient.h"
#import <AFNetworking.h>
#import "Constants.h"
#import "WordDataModel.h"

@implementation NetworkClient


// Base URL
NSString *const BASE_URL = @"http://www.nactem.ac.uk/software/acromine/dictionary.py";


// HTTP GET Request Parameters
NSString *const shortForm = @"sf";
NSString *const longForm = @"lf";


// A thread-safe shared instance
+ (instancetype)sharedInstance {
    static NetworkClient* sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NetworkClient alloc] init];
    });
    
    return sharedInstance;
}



// HTTP GET Request to get acronyms

- (void)getAcronym:(NSString *)acronym completion:(CompletionBlock)completion{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setObject:acronym forKey:shortForm];
    
    //NetworkClient
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSLog(@"GET Requesting");
    
    [operationManager GET:BASE_URL parameters:para success:^
     (AFHTTPRequestOperation *operation, id responseObject) {
         
        

         NSMutableArray *results = [NSMutableArray array];
         
        
         @try {
             for (NSDictionary *dict in responseObject[0][@"lfs"]){
                 //NSDictionary *lfData = dict
                 NSLog(@"Success JSON: %@", dict);

                 [results addObject: [[WordDataModel alloc] initWithDictionary:dict]];
             }
             
             NSLog(@"Success populated model: %@", results);

             
         }
         @catch (NSException *exception) {
             NSLog(@"%@%@", @"No results found for: ", acronym);
         }

         completion(results, nil);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error in GET request: %@", error);
         completion(nil, error);
         
     }];
    
    
}













@end
