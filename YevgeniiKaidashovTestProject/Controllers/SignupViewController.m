//
//  SignupViewController.m
//  TestProject
//
//  Created by Zhenya Kaidashov on 2/14/18.
//  Copyright © 2018 Zhenya Kaidashov. All rights reserved.
//

#import "SignupViewController.h"
#import "Signup.h"
#import "CharactersTableViewController.h"

@interface SignupViewController ()

@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self.nameTextField becomeFirstResponder];
    self.nameTextField.delegate = self;
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"SignupViewController Deallocated");
}

#pragma mark - Actions

- (IBAction)actionBackToLogin:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)actionSignup:(UIButton *)sender {
    NSString *name = self.nameTextField.text;
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    
    Signup *signupModel = [[Signup alloc] initWithName:name email:email andPassword:password];
    
    CharactersTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CharactersTableViewController"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    sender.enabled = NO;
    sender.alpha = 0.5;
    
    [signupModel signup:^{
        [[UIApplication sharedApplication] delegate].window.rootViewController = nav;
    } onFailure:^{
        sender.enabled = YES;
        sender.alpha = 1.0;
    }];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([textField isEqual:self.nameTextField]) {
        [self.emailTextField becomeFirstResponder];
    } else if ([textField isEqual:self.emailTextField]) {
        [self.passwordTextField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    
    return YES;
}

@end
