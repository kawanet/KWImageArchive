//
//  KWImageArchive.m
//  KWImageArchive
//
//  Created by Yusuke Kawasaki on 2013/09/21.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "KWImageArchive.h"
#import <zipzap/zipzap.h>

static NSURL *pathToURL(NSString *path) {
    NSURL *url;
    if ([path characterAtIndex:0] == '/') {
        url = [NSURL fileURLWithPath:path isDirectory:NO];
    } else {
        url = [[NSBundle mainBundle] resourceURL];
        url = [NSURL URLWithString:path relativeToURL:url];
    }
    return url;
}

@implementation KWImageArchive
{
    NSCache *_cache;
    ZZArchive *_archive;
    NSDictionary *_entries;
    NSArray *_allNames;
}

- (NSCache *)cache {
    if (_cache) return _cache;
    return _cache = [NSCache new];
}

- (void)loadArchiveWithPath:(NSString *)path error:(NSError **)errorPtr {
    NSURL *url = pathToURL(path);
    [self loadArchiveWithURL:url error:errorPtr];
}

- (void)loadArchiveWithURL:(NSURL *)url error:(NSError **)errorPtr {
    _archive = [ZZArchive archiveWithContentsOfURL:url];
    [_archive load:errorPtr];
}

- (NSDictionary *)entries {
    if (_entries) return _entries;
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    for(ZZArchiveEntry *entry in _archive.entries) {
        NSString *name = entry.fileName;
        if (!name) continue;
        if (!name.length) continue;
        if (dict[name]) continue;
        dict[name] = entry;
    }
    
    return _entries = [NSDictionary dictionaryWithDictionary:dict];
}

- (NSArray *)allNames {
    if (_allNames) return _allNames;
    
    NSMutableArray *array = [NSMutableArray new];
    NSMutableDictionary *check = [NSMutableDictionary new];
    
    for(ZZArchiveEntry *entry in _archive.entries) {
        NSString *name = entry.fileName;
        if (!name) continue;
        if (!name.length) continue;
        if (check[name]) continue;
        [array addObject:name];
    }
    
    return _allNames = [NSArray arrayWithArray:array];
}

- (NSData *)dataForName:(NSString*)name {
    ZZArchiveEntry *entry = self.entries[name];
    return entry.data;
}

- (UIImage *)imageForName:(NSString*)name {
    UIImage *cached = [self.cache objectForKey:name];
    if (cached) return cached;
    
    NSData *data = [self dataForName:name];
    if (!data) return nil;

    UIImage *image = [UIImage imageWithData:data];
    if (!image) return nil;
    if (!image.size.width) return nil;
    
    [self.cache setObject:image forKey:name];
    return image;
}

@end
