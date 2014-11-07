//
//  SocketIndex.h
//  OpenLock
//
//  Created by yons on 14-10-23.
//  Copyright (c) 2014年 yons. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Singleton.h"
@interface SocketIndex : NSObject
singleton_interface(SocketIndex)

@property (nonatomic,assign)NSInteger OrderIndex;

@end
