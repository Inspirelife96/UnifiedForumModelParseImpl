//
//  UFMService+TopicShareModel.m
//  UnifiedForumModelParseImpl
//
//  Created by XueFeng Chen on 2022/11/15.
//

#import "UFMService+TopicShareModel.h"

#import "UFMUserModel.h"
#import "UFMTopicModel.h"

@implementation UFMService (TopicShareModel)

+ (BOOL)userModel:(UFMUserModel *)userModel shareTopicModel:(UFMTopicModel *)topicModel toPlatform:(NSString *)toPlatform error:(NSError **)error {
    PFUser *fromUser = (PFUser *)userModel.metaData;
    UFPFTopic *topic = (UFPFTopic *)topicModel.metaData;
    
    return [UFPFService addShareTopic:topic fromUser:fromUser toPlatform:toPlatform error:error];
}

@end