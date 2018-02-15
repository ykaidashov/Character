//
//  User.m
//  YevgeniiKaidashovTestProject
//
//  Created by Zhenya Kaidashov on 2/14/18.
//  Copyright © 2018 Zhenya Kaidashov. All rights reserved.
//

#import "User.h"

@implementation User

- (id)initWithEmail:(NSString *)email andPassword:(NSString *)password
{
    self = [super init];
    if (self) {
        self.email = email;
        self.password = password;
    }
    return self;
}

- (id)initWithResponse:(NSDictionary *)response
{
    self = [super init];
    if (self) {
        self.uid = [[response objectForKey:@"uid"] integerValue];
        self.name = [response objectForKey:@"name"];
        self.email = [response objectForKey:@"email"];
        self.accessToken = [response objectForKey:@"access_token"];
        self.role = (UserRole)[response objectForKey:@"role"];
        self.status = (UserStatus)[response objectForKey:@"status"];
        self.createdAt = [[response objectForKey:@"created_at"] integerValue];
        self.updatedAt = [[response objectForKey:@"updated_at"] integerValue];
    }
    return self;
}

- (id)initWithName:(NSString *)name email:(NSString *)email andPassword:(NSString *)password;
{
    self = [super init];
    if (self) {
        self.name = name;
        self.email = email;
        self.password = password;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %@", self.name, self.accessToken];
}

@end
