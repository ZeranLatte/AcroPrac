//
//  SearchTableViewController.m
//  Acronym4M
//
//  Created by ZZZZeran on 4/15/16.
//  Copyright © 2016 Z Latte. All rights reserved.
//



#import "SearchTableViewController.h"
#import "NetworkClient.h"
#import "WordDataModel.h"

@interface SearchTableViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray<WordDataModel *> *wordsArray;


@end
@implementation SearchTableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hud = [[MBProgressHUD alloc]init];
    
    // Mock data
    //self.wordsArray = @[@"Apple", @"Google", @"Amazon", @"Yahoo", @"FaceBook"];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    
    // MARK: - TODO
    //self.searchController.searchResultsUpdater = self;
    
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    
    
    self.tableView = [self makeTableView];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    [self.view addSubview:_tableView];
    
    // For dismiss keyboard
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UITableView *)makeTableView {
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    return tableView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.wordsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Cell" forIndexPath:indexPath];
    
     //Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = self.wordsArray[indexPath.row].lf;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", (long)self.wordsArray[indexPath.row].since];
    return cell;
}



#pragma mark - SearchBar Control

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
    NSLog(@"Search Bar: search pressed %@", self.searchController.searchBar.text);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    
    // MARK: - TODO
    NSString *acro = self.searchController.searchBar.text;
    
    [[NetworkClient sharedInstance] getAcronym:acro completion:^(NSArray *result, NSError *error) {
        
        self.wordsArray = result;
        [self.tableView reloadData];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];

    }];
    

    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)handleTap:(UITapGestureRecognizer *)recoginer {
    
    [self.searchController.searchBar resignFirstResponder];
    
}

#pragma mark - UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


@end
