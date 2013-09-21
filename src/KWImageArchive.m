//
//  KWImageArchive.m
//  KWImageArchive
//
//  Created by Yusuke Kawasaki on 2013/09/21.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "KWImageArchive.h"

@implementation KWImageArchive

ZZArchive *_archive;
NSDictionary *_dictionary;

- (id)init {
    self = [super init];
    self.cache = [[NSMutableDictionary alloc] init];
    return self;
}

+ (instancetype)archiveWithPath:(NSString *)path error:(NSError **)errorPtr {
    return [[self alloc] initWithPath:path error:errorPtr];
}

+ (instancetype)archiveWithURL:(NSURL *)url error:(NSError **)errorPtr {
    return [[self alloc] initWithURL:url error:errorPtr];
}

- (id)initWithPath:(NSString *)path error:(NSError **)errorPtr {
    NSURL *resourceURL = [[NSBundle mainBundle] resourceURL];
    NSURL *url = [NSURL URLWithString:path relativeToURL:resourceURL];
    return [self initWithURL:url error:errorPtr];
}

- (id)initWithURL:(NSURL *)url error:(NSError **)errorPtr {
    self = [self init];
    _archive = [ZZArchive archiveWithContentsOfURL:url];
    [_archive load:errorPtr];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for(ZZArchiveEntry *entry in _archive.entries) {
        [dict setObject:entry forKey:entry.fileName];
    }
    _dictionary = [NSDictionary dictionaryWithDictionary:dict];
    
    return self;
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
    
    self.cache[name] =image;
    return image;
}

@end
