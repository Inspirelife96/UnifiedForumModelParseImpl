//
//  UFMService+TopicLikeModel.m
//  UnifiedForumModelParseImpl
//
//  Created by XueFeng Chen on 2022/11/15.
//

#import "UFMService+TopicLikeModel.h"

#import "UFMUserModel.h"
#import "UFMTopicModel.h"

@implementation UFMService (TopicLikeModel)

+ (void)addTopicLikeFromUserModel:(UFMUserModel *)fromUserModel toTopicModel:(UFMTopicModel *)toTopicModel error:(NSError **)error {
    PFUser *fromUser = (PFUser *)fromUserModel.metaData;
    UFPFTopic *toTopic = (UFPFTopic *)toTopicModel.metaData;
    [UFPFService addTopicLikeWithFromUser:fromUser toTopic:toTopic error:error];
}

+ (void)deleteTopicLikeFromUserModel:(UFMUserModel *)fromUserModel toTopicModel:(UFMTopicModel *)toTopicModel error:(NSError **)error {
    PFUser *fromUser = (PFUser *)fromUserModel.metaData;
    UFPFTopic *toTopic = (UFPFTopic *)toTopicModel.metaData;
    [UFPFService deleteTopicLikeFromUser:fromUser toTopic:toTopic error:error];
}

@end