//
//  WordDataModel.m
//  Acronym4M
//
//  Created by ZZZZeran on 4/17/16.
//  Copyright © 2016 Z Latte. All rights reserved.
//

#import "WordDataModel.h"
#import "Constants.h"



@implementation WordDataModel


- (id)initWithDictionary:(NSDictionary *)dictionary {
    self.freq = ((NSString *)dictionary[KEY_FREQ]).integerValue;
    self.lf = dictionary[KEY_LF];
    self.since = ((NSString *)dictionary[KEY_SINCE]).integerValue;
    self.vars = [NSArray array];
    
    
    NSMutableArray *varsArray = [[NSMutableArray alloc] init];
    for (NSDictionary *variation in dictionary[KEY_VARS] ){
        WordDataModel *dataModel = [[WordDataModel alloc] initWithDictionary:variation];
        [varsArray addObject:dataModel];
    }
    
    self.vars = varsArray;
    return [self init];
}

@end
