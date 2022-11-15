//
//  UFMReplyModel.m
//  Bolts
//
//  Created by XueFeng Chen on 2022/10/22.
//

#import "UFMReplyModel.h"

#import "UFMUserModel.h"

@implementation UFMReplyModel

- (instancetype)initWithMetaData:(id)metaData error:(NSError **)error {
    if (self = [super initWithMetaData:metaData error:error]) {
        if ([metaData isKindOfClass:[UFPFReply class]]) {
            UFPFReply *reply = (UFPFReply *)metaData;
            
            self.replyId = reply.objectId;
            
            self.content = reply.content;
            
            self.likeCount = [reply.likeCount integerValue];
            
            self.toPostId = reply.toPost.objectId;
            
            if (reply.toReply) {
                self.toReplyId = reply.toReply.objectId;
            }
            
            PFUser *fromUser = reply.fromUser;
            [fromUser fetchIfNeeded:error];
            if (*error) {
                return nil;
            }
            
            self.fromUserModel = [[UFMUserModel alloc] initWithMetaData:fromUser error:error];
            if (*error) {
                return nil;
            }
            
            PFUser *toUser = reply.toPost.fromUser;
            if (reply.toReply) {
                toUser = reply.toReply.fromUser;
            }
            [toUser fetchIfNeeded:error];
            if (*error) {
                return nil;
            }

            self.toUserModel = [[UFMUserModel alloc] initWithMetaData:toUser error:error];
            if (*error) {
                return nil;
            }
        }
    }
    
    return self;
}

@end
