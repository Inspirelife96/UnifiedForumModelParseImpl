//
//  UFMObjectModel.m
//  Bolts
//
//  Created by XueFeng Chen on 2022/10/22.
//

#import "UFMObjectModel.h"

@implementation UFMObjectModel

- (instancetype)init {
    return [self initWithMetaData:@{}];
}

- (instancetype)initWithMetaData:(id)metaData {
    NSError *error = nil;
    return [self initWithMetaData:metaData error:&error];
}

- (instancetype)initWithMetaData:(id)metaData error:(NSError *__autoreleasing  _Nullable *)error {
    if (self = [super init]) {
        self.metaData = metaData;
    }
    
    return self;
}

@end
