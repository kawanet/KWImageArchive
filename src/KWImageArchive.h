//
//  KWImageArchive.h
//  KWImageArchive
//
//  Created by Yusuke Kawasaki on 2013/09/21.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KWImageArchive : NSObject

@property NSMutableDictionary *cache;

- (void)loadArchiveWithPath:(NSString *)path error:(NSError **)errorPtr;
- (void)loadArchiveWithURL:(NSURL *)url error:(NSError **)errorPtr;
- (NSUInteger)count;
- (NSString *)nameAtIndex:(NSUInteger)index;
- (NSData *)dataForName:(NSString*)name;
- (UIImage *)imageForName:(NSString*)name;

@end
