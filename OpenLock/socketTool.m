//
//  socketTool.m
//  socketClient
//
//  Created by yons on 14-10-13.
//  Copyright (c) 2014年 yons. All rights reserved.
//

#import "socketTool.h"
#import "SocketIndex.h"
@implementation socketTool

-(id)initWithTag:(NSInteger)tag
{
    self =[super init];
    if (self) {
        [self baseSetting:tag];
    }
    return self;
}


-(void)baseSetting:(NSInteger)tag
{
    _tag =tag;
    dispatch_queue_t mainQueue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    asyncSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:mainQueue];
    [self connect];
}

#pragma mark -

- (void)connect {
	[asyncSocket connectToHost:@"127.0.0.1" onPort:8888 error:nil];  //端口和IP 设置 本机测试用127.0.0.1 端口必须和服务器一致
    [asyncSocket setAutoDisconnectOnClosedReadStream:YES];
    
}


//客户端发送命令给服务器
- (void)sendHTTPRequest:(NSString*)sendData tag:(long)tag
{
    NSData *data = [sendData dataUsingEncoding:NSUTF8StringEncoding];
    
	[asyncSocket writeData:data withTimeout:-1 tag:tag];
    
}

//读取服务器的响应
- (void)readWithTag:(long)tag {

	[asyncSocket readDataToData:[GCDAsyncSocket CRLFData] withTimeout:-1 tag:tag];
}

#pragma mark -
#pragma mark AsyncSocket Methods


- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
	NSLog(@"err %@",err.localizedDescription);
    
	[asyncSocket setDelegate:nil];
	
	asyncSocket = nil;
    
    dispatch_async(dispatch_get_main_queue(), ^{
            
        [[NSNotificationCenter defaultCenter] postNotificationName:loseServer object:nil];
            
    });
    
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port {
	NSLog(@"Connected To %@:%i.", host, port);
    //如果连接成功创建监听的socket Tag
    for(int i =0;i<100;i++)
    {
        [self readWithTag:i];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:connecting object:@(_tag)];
    });
  
}

//专负责读取客户端把套接字请求的数据完成写入服务器的时候调用，出错不调用
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
	NSLog(@"要写入服务器的数据  ---- %@----%ld",sock,tag);
    
}

//专门负责读取服务器返回的数据，出错不调用
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    
    NSString *string = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];

    NSLog(@"从服务器读取到的数据 ---- %@ ----- %@----- %ld ",sock, string,tag);
    
    if([string isEqualToString:@"开锁命令--------\r\n"])
    {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSNumber *successTag =@([SocketIndex sharedSocketIndex].OrderIndex);
            
            [[NSNotificationCenter defaultCenter] postNotificationName:openSuccess object:successTag];
        });
      
    }
}

#pragma mark -
#pragma mark Memory Management



@end
