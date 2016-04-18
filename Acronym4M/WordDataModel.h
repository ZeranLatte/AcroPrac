//
//  WordDataModel.h
//  Acronym4M
//
//  Created by ZZZZeran on 4/17/16.
//  Copyright © 2016 Z Latte. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WordDataModel : NSObject

// properties
@property (nonatomic, strong) NSString *lf;
@property (nonatomic, assign) NSInteger freq;
@property (nonatomic, assign) NSInteger since;
@property (nonatomic, strong) NSArray<WordDataModel*> *vars;

- (id)initWithDictionary:(NSDictionary *)values;


@end
