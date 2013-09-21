//
//  KWImageArchive.m
//  KWImageArchive
//
//  Created by Yusuke Kawasaki on 2013/09/21.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "KWImageArchive.h"
#import <zipzap/zipzap.h>

@implementation KWImageArchive

NSMutableDictionary *_cache;
ZZArchive *_archive;
NSDictionary *_entries;
NSArray *_names;

NSURL *_pathToURL(NSString *path) {
    NSURL *url;
    if ([path characterAtIndex:0] == '/') {
        url = [NSURL fileURLWithPath:path isDirectory:NO];
    } else {
        url = [[NSBundle mainBundle] resourceURL];
        url = [NSURL URLWithString:path relativeToURL:url];
    }
    return url;
}

- (void)loadArchiveWithPath:(NSString *)path error:(NSError **)errorPtr {
    NSURL *url = _pathToURL(path);
    [self loadArchiveWithURL:url error:errorPtr];
}

- (void)loadArchiveWithURL:(NSURL *)url error:(NSError **)errorPtr {
    _archive = [ZZArchive archiveWithContentsOfURL:url];
    BOOL loaded = [_archive load:errorPtr];
    if (!loaded) return;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableArray *array = [NSMutableArray array];
    for(ZZArchiveEntry *entry in _archive.entries) {
        if (!entry) continue;
        dict[entry.fileName] = entry;
        [array addObject:entry.fileName];
    }
    
    _entries = [NSDictionary dictionaryWithDictionary:dict];
    _names = [NSArray arrayWithArray:array];
}

- (NSArray *)allNames {
    return _names;
}

- (NSUInteger)count {
    return _archive.entries.count;
}

- (NSString *)nameAtIndex:(NSUInteger)index {
    ZZArchiveEntry *entry = _archive.entries[index];
    return entry.fileName;
}

- (NSData *)dataForName:(NSString*)name {
    ZZArchiveEntry *entry = _entries[name];
    return entry.data;
}

- (UIImage *)imageForName:(NSString*)name {
    // create empty dictionary if not found
    if (!_cache) {
        _cache = [NSMutableDictionary dictionary];
    }
    
    // check cached image available
    UIImage *cache = _cache[name];
    if (cache) return cache;
    
    // restore image
    NSData *data = [self dataForName:name];
    if (!data) return nil;
    UIImage *image = [UIImage imageWithData:data];
    if (!image) return nil;
    
    // store result to cache
    _cache[name] = image;
    return image;
}

@end
