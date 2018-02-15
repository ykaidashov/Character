//
//  CharactersTableViewController.m
//  YevgeniiKaidashovTestProject
//
//  Created by Zhenya Kaidashov on 2/14/18.
//  Copyright © 2018 Zhenya Kaidashov. All rights reserved.
//

#import "CharactersTableViewController.h"
#import "ApiManager.h"

@interface CharactersTableViewController ()

@property (strong, nonatomic) NSArray *characters;

@end

@implementation CharactersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Characters";
    
    UIBarButtonItem *updateButton = [[UIBarButtonItem alloc] initWithTitle:@"Get other text" style:UIBarButtonItemStylePlain target:self action:@selector(actionUpdateCharacters:)];
    
    self.navigationItem.rightBarButtonItem = updateButton;
    
    [self loadData];
    
}

- (void)loadData {
    [[ApiManager sharedManager] getText:^(NSString *text) {
        self.characters = [self prepareData:text];
        [self.tableView reloadData];
    }];
}

- (NSArray *)prepareData:(NSString *)text {
    
    NSMutableArray *tempArray = [NSMutableArray array];
    
    while ([text length] > 0) {
        
        NSString *character = [text substringToIndex:1];
        
        int count = (int)[self numberOfCharacter:character inString:text];
        
        if (count > 0) {
            NSNumber *numberOfCharacter = [NSNumber numberWithInt:count];
            
            if ([character isEqualToString:@" "]) {
                [tempArray addObject:[NSDictionary dictionaryWithObject:numberOfCharacter forKey:@"space"]];
            } else {
                [tempArray addObject:[NSDictionary dictionaryWithObject:numberOfCharacter forKey:character]];
            }
            
            
        }
        
        text = [text stringByReplacingOccurrencesOfString:character withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, text.length)];
    }
    
    return tempArray;
}

- (NSInteger)numberOfCharacter:(NSString *)character inString:(NSString *)text {
    NSRange search = NSMakeRange(0, text.length);
    NSInteger counter = 0;
    
    while (YES) {
        NSRange range = [text rangeOfString:character options:NSCaseInsensitiveSearch range:search];
        
        if (range.location != NSNotFound) {
            
            NSInteger index = range.location + range.length;
            
            search.location = index;
            search.length = (NSInteger)[text length] - index;
            
            counter++;
        } else {
            break;
        }
        
    }
    
    return counter;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void)actionUpdateCharacters:(UIBarButtonItem *)sender {
    [self loadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.characters count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"CharacterCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSDictionary *tempItem  = [self.characters objectAtIndex:indexPath.row];
    NSArray *keys = [tempItem allKeys];
    
    
    if ([keys count] > 0) {
        NSString *character = [keys firstObject];
        NSInteger count = [[tempItem objectForKey:[keys firstObject]] integerValue];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ - %ld %@", character, count, (count > 1) ? @"times" : @"time"];
    }
    
    return cell;
}

@end
