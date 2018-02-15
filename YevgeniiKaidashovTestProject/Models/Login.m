//
//  Login.m
//  TestProject
//
//  Created by Zhenya Kaidashov on 2/14/18.
//  Copyright © 2018 Zhenya Kaidashov. All rights reserved.
//

#import "Login.h"
#import "User.h"
#import "ApiManager.h"

@implementation Login

- (id)initWithEmail:(NSString *)email andPassword:(NSString *)password;
{
    self = [super init];
    if (self) {
        self.email = email;
        self.password = password;
    }
    return self;
}

- (void)login:(void(^)(void))success onFailure:(void(^)(void))failure {
    if ([self validate]) {
        User *user = [[User alloc] initWithEmail:self.email andPassword:self.password];
        [[ApiManager sharedManager] loginUser:user onSuccess:success onFailure:failure];
    } else {
        failure();
    }
}

- (BOOL)validate {
    if ([self isValidEmailAddress] && [self isNotEmpty:self.password] && [self isValidPasswordLength]) {
        return YES;
    }
    return NO;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Email: %@, Password: %@", self.email, self.password];
}

@end
