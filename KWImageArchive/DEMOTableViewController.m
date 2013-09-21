//
//  DEMOTableViewController.m
//  KWImageSprites
//
//  Created by Yusuke Kawasaki on 2013/09/21.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "DEMOTableViewController.h"
#import "KWImageArchive.h"

@interface DEMOTableViewController ()

@end

@implementation DEMOTableViewController

KWImageArchive *archive;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSError *err = nil;
    archive = [KWImageArchive archiveWithPath:@"iconic.zip" error:&err];
    if (err) {
        NSLog(@"%@", err);
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return archive.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString *name = [archive nameAtIndex:indexPath.item];
    cell.textLabel.text = name;
    cell.imageView.image = [archive imageForName:name];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    return cell;
}

@end
