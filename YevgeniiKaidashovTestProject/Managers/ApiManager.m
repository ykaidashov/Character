//
//  ApiManager.m
//  YevgeniiKaidashovTestProject
//
//  Created by Zhenya Kaidashov on 2/14/18.
//  Copyright © 2018 Zhenya Kaidashov. All rights reserved.
//

#import "ApiManager.h"
#import "AFNetworking.h"
#import "User.h"

@interface ApiManager ()

@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;
@property (strong, nonatomic) User *user;

@end

@implementation ApiManager

+ (ApiManager *)sharedManager {
    static ApiManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ApiManager alloc] init];
    });
    
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSURL *url = [NSURL URLWithString:@"https://apiecho.cf/api/"];
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
        //self.sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    return self;
}

- (void)loginUser:(User *)user onSuccess:(void(^)(void))success onFailure:(void(^)(void))failure {
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            user.email, @"email",
                            user.password, @"password",
                            nil];
    
    [self sendRequestTo:@"login/" withParams:params onSuccess:success onFailure:failure];
}

- (void)signupUser:(User *)user onSuccess:(void(^)(void))success onFailure:(void(^)(void))failure {
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            user.name, @"name",
                            user.email, @"email",
                            user.password, @"password",
                            nil];
    
    [self sendRequestTo:@"signup/" withParams:params onSuccess:success onFailure:failure];
}

- (void)sendRequestTo:(NSString *)url withParams:(NSDictionary *)params onSuccess:(void(^)(void))success onFailure:(void(^)(void))failure {
    
    [self.sessionManager
     POST:url
     parameters:params
     progress:nil
     success:^(NSURLSessionTask *task, NSDictionary *responseObject) {
         User *user = [[User alloc] initWithResponse:[responseObject objectForKey:@"data"]];
         self.user = user;
         if (success) {
             success();
         }
     }
     failure:^(NSURLSessionTask *operation, NSError *error) {
         NSLog(@"Error: %@", [error localizedDescription]);
         failure();
     }];
    
}

- (void)getText:(void(^)(NSString *text))onSuccess {
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"en_US", @"locale",
                            nil];
    
    NSString *authValue = [NSString stringWithFormat:@"Bearer %@", self.user.accessToken];
    [self.sessionManager.requestSerializer setValue:authValue forHTTPHeaderField:@"Authorization"];
    
    [self.sessionManager
     GET:@"get/text/"
     parameters:params
     progress:nil
     success:^(NSURLSessionTask *task, NSDictionary *responseObject) {
         if (onSuccess) {
             onSuccess([responseObject objectForKey:@"data"]);
         }
     }
     failure:^(NSURLSessionTask *operation, NSError *error) {
         NSLog(@"Error: %@", [error localizedDescription]);
     }];
}

@end
