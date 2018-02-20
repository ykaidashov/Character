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

@property (strong, nonatomic) NSCountedSet *countedSet;
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
    
    NSCountedSet *countedSet = [NSCountedSet set];
    
    for (int i = 0; i < text.length; i++) {
        NSString *character = [text substringWithRange:NSMakeRange(i, 1)];
        
        if ([character isEqualToString:@" "]) {
            character = @"space";
        }
        
        [countedSet addObject:character];
        
    }
    
    self.countedSet = countedSet;
    
    return [countedSet allObjects];
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
    
    NSString *character = [self.characters objectAtIndex:indexPath.row];
    NSInteger count = [self.countedSet countForObject:character];

    if (count > 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@ - %ld %@", character, count, (count > 1) ? @"times" : @"time"];
    }
    
    return cell;
}

@end
