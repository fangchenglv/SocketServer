//
//  SocketManager.m
//  SocketServer
//
//  Created by lfc on 2019/10/15.
//  Copyright © 2019 lfc. All rights reserved.
//

#import "SocketManager.h"
#import "GCDAsyncSocket.h"

@implementation SocketManager
+ (SocketManager *)sharedSocketManager
{
    static SocketManager *socket = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        socket = [[SocketManager alloc] init];
    });
    return socket;
}
@end
