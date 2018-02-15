//
//  Signup.m
//  TestProject
//
//  Created by Zhenya Kaidashov on 2/14/18.
//  Copyright © 2018 Zhenya Kaidashov. All rights reserved.
//

#import "Signup.h"
#import "User.h"
#import "ApiManager.h"

@implementation Signup

- (id)initWithName:(NSString *)name email:(NSString *)email andPassword:(NSString *)password
{
    self = [super init];
    if (self) {
        self.name = name;
        self.email = email;
        self.password = password;
    }
    return self;
}

- (void)signup:(void(^)(void))success onFailure:(void(^)(void))failure {
    if ([self validate]) {
        User *user = [[User alloc] initWithName:self.name email:self.email andPassword:self.password];
        [[ApiManager sharedManager] signupUser:user onSuccess:success onFailure:failure];
    } else {
        failure();
    }
}

- (BOOL)validate {
    if ([self isValidEmailAddress]
        && [self isNotEmpty:self.name]
        && [self isNotEmpty:self.password]
        && [self isValidPasswordLength]) {
        return YES;
    }
    return NO;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Name: %@, Email: %@, Password: %@", self.name, self.email, self.password];
}

@end
