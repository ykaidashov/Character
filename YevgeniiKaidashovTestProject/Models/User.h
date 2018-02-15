//
//  User.h
//  YevgeniiKaidashovTestProject
//
//  Created by Zhenya Kaidashov on 2/14/18.
//  Copyright © 2018 Zhenya Kaidashov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    UserOnly    = 1,
    Manager     = 2,
    Admin       = 10,
} UserRole;

typedef enum {
    Pending = 1,
    Deleted = 2,
    Active  = 10,
} UserStatus;

@interface User : NSObject

@property (assign, nonatomic) NSInteger uid;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *accessToken;
@property (assign, nonatomic) UserRole role;
@property (assign, nonatomic) UserStatus status;
@property (assign, nonatomic) NSInteger createdAt;
@property (assign, nonatomic) NSInteger updatedAt;

- (id)initWithName:(NSString *)name email:(NSString *)email andPassword:(NSString *)password;
- (id)initWithEmail:(NSString *)email andPassword:(NSString *)password;
- (id)initWithResponse:(NSDictionary *)response;

@end
