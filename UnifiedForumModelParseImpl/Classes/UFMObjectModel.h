//
//  UFMObjectModel.h
//  Bolts
//
//  Created by XueFeng Chen on 2022/10/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UFMObjectModel : NSObject

@property (nonatomic, strong) id metaData; // 原始数据，类型不确定

- (instancetype)init;
- (instancetype)initWithMetaData:(id)metaData error:(NSError **)error NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithMetaData:(id)metaData;

@end

NS_ASSUME_NONNULL_END
