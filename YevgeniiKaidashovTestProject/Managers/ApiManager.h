//
//  ApiManager.h
//  YevgeniiKaidashovTestProject
//
//  Created by Zhenya Kaidashov on 2/14/18.
//  Copyright © 2018 Zhenya Kaidashov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

@interface ApiManager : NSObject

+ (ApiManager *)sharedManager;

- (void)loginUser:(User *)user onSuccess:(void(^)(void))success onFailure:(void(^)(void))failure;
- (void)signupUser:(User *)user onSuccess:(void(^)(void))success onFailure:(void(^)(void))failure;

- (void)getText:(void(^)(NSString *text))onSuccess;

@end
