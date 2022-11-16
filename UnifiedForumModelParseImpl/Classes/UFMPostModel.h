//
//  UFMPostModel.h
//  Bolts
//
//  Created by XueFeng Chen on 2022/10/22.
//

#import "UFMObjectModel.h"

@class UFMFileModel;
@class UFMReplyModel;
@class UFMUserModel;

NS_ASSUME_NONNULL_BEGIN

@interface UFMPostModel : UFMObjectModel

// ID
@property (nonatomic, copy) NSString *postId;

// post内容，post不允许有title
@property (nonatomic, copy) NSString *content;

// post可以有附加内容
@property (nonatomic, strong) NSArray<UFMFileModel *> *fileModelArray;

// 针对post的部分回复，用于展示，上限5条
@property (nonatomic, strong) NSArray<UFMReplyModel *> *replyModelArray;

// 回复的总数
@property (nonatomic, assign) NSInteger replyCount;

// 点赞数
@property (nonatomic, assign) NSInteger likeCount;

// 是针对哪个Topic的评论
@property (nonatomic, copy) NSString *toTopicId;

// 创建时间
@property (nonatomic, strong) NSDate *createdAt;

// 发布者
@property (nonatomic, strong) UFMUserModel *fromUserModel;

@end

NS_ASSUME_NONNULL_END
