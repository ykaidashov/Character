//
//  Login.h
//  TestProject
//
//  Created by Zhenya Kaidashov on 2/14/18.
//  Copyright © 2018 Zhenya Kaidashov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"

@interface Login : Model

- (id)initWithEmail:(NSString *)email andPassword:(NSString *)password;
- (void)login:(void(^)(void))success onFailure:(void(^)(void))failure;

@end
