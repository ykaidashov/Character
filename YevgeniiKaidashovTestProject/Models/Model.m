//
//  Model.m
//  YevgeniiKaidashovTestProject
//
//  Created by Zhenya Kaidashov on 2/14/18.
//  Copyright © 2018 Zhenya Kaidashov. All rights reserved.
//

#import "Model.h"

@implementation Model

- (BOOL)isValidEmailAddress {
    
    NSString *pattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}" ;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    
    return [predicate evaluateWithObject:self.email];
}

- (BOOL)isValidPasswordLength {
    return [self.password length] >=8;
}

- (BOOL)isNotEmpty:(NSString *)string {
    
    return ([string length] > 0);
}

@end
