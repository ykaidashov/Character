//
//  LoginViewController.m
//  TestProject
//
//  Created by Zhenya Kaidashov on 2/14/18.
//  Copyright © 2018 Zhenya Kaidashov. All rights reserved.
//

#import "LoginViewController.h"
#import "Login.h"
#import "CharactersTableViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self.emailTextField becomeFirstResponder];
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"LoginViewController Deallocated");
}

#pragma mark - Actions

- (IBAction)actionLogin:(UIButton *)sender {
    
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    
    Login *loginModel = [[Login alloc] initWithEmail:email andPassword:password];
    
    sender.enabled = NO;
    sender.alpha = 0.5;
    
    CharactersTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CharactersTableViewController"];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [loginModel login:^{
        [[UIApplication sharedApplication] delegate].window.rootViewController = nav;
    } onFailure:^{
        sender.enabled = YES;
        sender.alpha = 1.0;
    }];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    if ([textField isEqual:self.emailTextField]) {
        [self.passwordTextField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    
    return YES;
}

@end
