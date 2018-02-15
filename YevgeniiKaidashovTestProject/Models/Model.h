//
//  Model.h
//  YevgeniiKaidashovTestProject
//
//  Created by Zhenya Kaidashov on 2/14/18.
//  Copyright © 2018 Zhenya Kaidashov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *password;

- (BOOL)isValidEmailAddress;
- (BOOL)isNotEmpty:(NSString *)string;
- (BOOL)isValidPasswordLength;

@end
