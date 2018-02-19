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

@property (strong, nonatomic) NSDictionary *characters;

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

- (NSDictionary *)prepareData:(NSString *)text {

    NSMutableDictionary *tempDictionary = [NSMutableDictionary dictionary];
    
    for (int i = 0; i < text.length; i++) {
        NSString *character = [text substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [text rangeOfString:character];
        
        if ([character isEqualToString:@" "]) {
            character = @"space";
        }
        
        if (range.location != NSNotFound) {
            NSNumber *number = [tempDictionary objectForKey:character];
            if (number) {
                int count = (int)[number integerValue];
                [tempDictionary setObject:[NSNumber numberWithInt:(count + 1)] forKey:character];
            } else {
                [tempDictionary setObject:[NSNumber numberWithInt:1] forKey:character];
            }
        }
        
    }
    
    return tempDictionary;
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
    
    NSString *character = [[self.characters allKeys] objectAtIndex:indexPath.row];
    NSInteger count = [[[self.characters allValues] objectAtIndex:indexPath.row] integerValue];
    
    
    if (count > 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@ - %ld %@", character, count, (count > 1) ? @"times" : @"time"];
    }
    
    return cell;
}

@end
