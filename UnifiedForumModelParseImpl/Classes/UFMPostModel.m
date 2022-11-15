//
//  UFMPostModel.m
//  Bolts
//
//  Created by XueFeng Chen on 2022/10/22.
//

#import "UFMPostModel.h"

#import "UFMUserModel.h"
#import "UFMFileModel.h"
#import "UFMReplyModel.h"

@implementation UFMPostModel

- (instancetype)initWithMetaData:(id)metaData error:(NSError **)error {
    if (self = [super initWithMetaData:metaData error:error]) {
        
        // 如果metaData是INSPost类型，则可以进行如下的转换
        if ([metaData isKindOfClass:[UFPFPost class]]) {
            UFPFPost *post = (UFPFPost *)metaData;
            
            self.postId = post.objectId;
            
            self.content = post.content;
            
            NSMutableArray *fileObjectModelMutableArray = [[NSMutableArray alloc] init];
            [post.mediaFileObjects enumerateObjectsUsingBlock:^(PFFileObject * _Nonnull fileObject, NSUInteger idx, BOOL * _Nonnull stop) {
                UFMFileModel *fileObjectModel = [[UFMFileModel alloc] initWithMetaData:fileObject error:nil];
                [fileObjectModelMutableArray addObject:fileObjectModel];
            }];
            self.fileObjectModelArray = [fileObjectModelMutableArray copy];
            
            NSMutableArray *replyModelMutableArray = [[NSMutableArray alloc] init];
            NSArray *replies = post.replies;
            for (NSInteger i = 0; i < replies.count; i++) {
                UFPFReply *reply = replies[i];
                [reply fetchIfNeeded:error];
                if (*error) {
                    return nil;
                }
                
                UFMReplyModel *replyModel = [[UFMReplyModel alloc] initWithMetaData:reply error:error];
                if (*error) {
                    return nil;
                }
                
                [replyModelMutableArray addObject:replyModel];
            }
            self.replyModelArray = [replyModelMutableArray copy];
            
            self.replyCount = [post.replyCount integerValue];
            
            self.likeCount = [post.likeCount integerValue];
            
            self.createdAt = post.createdAt;
            
            PFUser * fromUser = post.fromUser;
            [fromUser fetchIfNeeded:error];
            if (*error) {
                return nil;
            }
            
            self.fromUserModel = [[UFMUserModel alloc] initWithMetaData:fromUser error:error];
            if (*error) {
                return nil;
            }
        }
    }
    
    return self;
}

@end
