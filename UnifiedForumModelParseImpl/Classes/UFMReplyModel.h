//
//  UFMReplyModel.h
//  Bolts
//
//  Created by XueFeng Chen on 2022/10/22.
//

#import "UFMObjectModel.h"

@class UFMUserModel;

NS_ASSUME_NONNULL_BEGIN

@interface UFMReplyModel : UFMObjectModel

// ID
@property (nonatomic, copy) NSString *replyId;

// 回复内容，Reply仅能包含文字，没有标题，且不允许包含其他附件内容
@property (nonatomic, copy) NSString *content;

// 点赞数
@property (nonatomic, assign) NSInteger likeCount;

// 针对哪个Post的回复
@property (nonatomic, copy) NSString *toPostId;

// 针对哪个Reply的回复，这是由于存在针对回复的回复
@property (nonatomic, copy) NSString *toReplyId;

// 发布者
@property (nonatomic, strong) UFMUserModel *fromUserModel;

// 针对谁的回复
@property (nonatomic, strong) UFMUserModel *toUserModel;

@end

NS_ASSUME_NONNULL_END
