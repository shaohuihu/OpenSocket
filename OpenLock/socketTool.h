//
//  socketTool.h
//  socketClient
//
//  Created by yons on 14-10-13.
//  Copyright (c) 2014年 yons. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "AsyncSocket.h"

#import "GCDAsyncSocket.h"


typedef void(^success)();

@interface socketTool : NSObject
{
   // AsyncSocket *socket;
    
    GCDAsyncSocket *asyncSocket;
}
- (void)sendHTTPRequest:(NSString*)sendData tag:(long)tag;

-(id)initWithTag:(NSInteger)tag;
@property (nonatomic,assign) success block;

@property (nonatomic,assign) NSInteger tag;
@end
