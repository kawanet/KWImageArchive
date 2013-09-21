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

ZZArchive *_archive;
NSDictionary *_dictionary;

- (id)init {
    self = [super init];
    self.cache = [[NSMutableDictionary alloc] init];
    return self;
}

- (void)loadArchiveWithPath:(NSString *)path error:(NSError **)errorPtr {
    NSURL *url;
    if ([path characterAtIndex:0] == '/') {
        url = [NSURL fileURLWithPath:path isDirectory:NO];
    } else {
        url = [[NSBundle mainBundle] resourceURL];
        url = [NSURL URLWithString:path relativeToURL:url];
    }
    [self loadArchiveWithURL:url error:errorPtr];
}

- (void)loadArchiveWithURL:(NSURL *)url error:(NSError **)errorPtr {
    _archive = [ZZArchive archiveWithContentsOfURL:url];
    BOOL loaded = [_archive load:errorPtr];
    if (!loaded) return;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for(ZZArchiveEntry *entry in _archive.entries) {
        if (!entry) continue;
        dict[entry.fileName] = entry;
    }
    _dictionary = [NSDictionary dictionaryWithDictionary:dict];
}

- (NSUInteger)count {
    return _archive.entries.count;
}

- (NSString *)nameAtIndex:(NSUInteger)index {
    ZZArchiveEntry *entry = _archive.entries[index];
    return entry.fileName;
}

- (NSData *)dataForName:(NSString*)name {
    ZZArchiveEntry *entry = _dictionary[name];
    return entry.data;
}

- (UIImage *)imageForName:(NSString*)name {
    // check cached image available
    UIImage *cache = self.cache[name];
    if (cache) return cache;
    
    // restore image
    NSData *data = [self dataForName:name];
    if (!data) return nil;
    UIImage *image = [UIImage imageWithData:data];
    if (!image) return nil;
    
    self.cache[name] =image;
    return image;
}

@end
