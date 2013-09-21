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
    archive = [[KWImageArchive alloc] init];
    [archive loadArchiveWithPath:@"iconic.zip" error:&err];
    
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
    
    // filename
    NSString *name = [archive nameAtIndex:indexPath.item];
    cell.textLabel.text = name;
    
    // image
    UIImage *image = [archive imageForName:name];
    cell.imageView.image = image;
    cell.textLabel.enabled = !!image;
    
    return cell;
}

@end
