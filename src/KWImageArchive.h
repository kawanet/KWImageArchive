//
//  KWImageArchive.h
//  KWImageArchive
//
//  Created by Yusuke Kawasaki on 2013/09/21.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <zipzap/zipzap.h>

@interface KWImageArchive : NSObject

@property NSMutableDictionary *cache;

+ archiveWithPath:(NSString *)path error:(NSError **)errorPtr;
+ archiveWithURL:(NSURL *)url error:(NSError **)errorPtr;
- (id)initWithPath:(NSString *)path error:(NSError **)errorPtr;
- (id)initWithURL:(NSURL *)url error:(NSError **)errorPtr;
- (NSUInteger)count;
- (NSString *)nameAtIndex:(NSUInteger)index;
- (NSData *)dataForName:(NSString*)name;
- (UIImage *)imageForName:(NSString*)name;

@end
