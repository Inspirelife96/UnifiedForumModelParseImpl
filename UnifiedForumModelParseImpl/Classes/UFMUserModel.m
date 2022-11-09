//
//  UFMUserModel.m
//  Bolts
//
//  Created by XueFeng Chen on 2022/10/22.
//

#import "UFMUserModel.h"

#import "UFMFileModel.h"

@implementation UFMUserModel

- (instancetype)initWithMetaData:(id)metaData error:(NSError **)error {
    if (self = [super initWithMetaData:metaData error:error]) {
        NSAssert([metaData isKindOfClass:[PFUser class]], @"metaData type is incorrect");
        
        PFUser *user = (PFUser *)metaData;
        
        self.userId = user.objectId;
        
        self.username = user.username;
        
        self.joinedAt = user.createdAt;
        
        UFPFStatisticsInfo *statisticsInfo = [user objectForKey:@"statisticsInfo"];
        [statisticsInfo fetchIfNeeded:error];
        if (*error) {
            return nil;
        } else {
            self.profileviews = [statisticsInfo.profileViews integerValue];
            self.reputation = [statisticsInfo.reputation integerValue];
            self.topicCount = [statisticsInfo.topicCount integerValue];
            self.postCount = [statisticsInfo.postCount integerValue];
            self.followingCount = [statisticsInfo.followingCount integerValue];
            self.followerCount = [statisticsInfo.followerCount integerValue];
            self.likedCount = [statisticsInfo.likedCount integerValue];
        }
                
        self.isLocked = [[user objectForKey:UFPFUserKeyIsLocked] boolValue];

        self.isDeleted = [[user objectForKey:UFPFUserKeyIsDeleted] boolValue];

        PFFileObject *avatarFileObject = [user objectForKey:UFPFUserKeyAvatar];
        if (avatarFileObject) {
            self.avatarModel = [[UFMFileModel alloc] initWithMetaData:avatarFileObject error:nil];
        } else {
            self.avatarModel = nil;
        }
        
        PFFileObject *backgroundImageFileObject = [user objectForKey:UFPFUserKeyBackgroundImage];
        if (backgroundImageFileObject) {
            self.backgroundImageModel = [[UFMFileModel alloc] initWithMetaData:backgroundImageFileObject error:nil];
        } else {
            self.backgroundImageModel = nil;
        }
        
        NSString *bio = [user objectForKey:UFPFUserKeyBio];
        if (bio && ![bio isEqualToString:@""]) {
            self.bio = bio;
        } else {
            self.bio = nil;
        }
        
        self.isAnonymousUser = [PFAnonymousUtils isLinkedWithUser:user];
    }
    
    return self;
}

@end
