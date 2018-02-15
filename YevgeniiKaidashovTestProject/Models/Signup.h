//
//  Signup.h
//  TestProject
//
//  Created by Zhenya Kaidashov on 2/14/18.
//  Copyright © 2018 Zhenya Kaidashov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"

@interface Signup : Model

@property (strong, nonatomic) NSString *name;

- (id)initWithName:(NSString *)name email:(NSString *)email andPassword:(NSString *)password;
- (void)signup:(void(^)(void))success onFailure:(void(^)(void))failure;

@end
