//
//  ViewController.h
//  SocketServer
//
//  Created by lfc on 2019/10/15.
//  Copyright © 2019 lfc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCDAsyncSocket.h"
@interface ViewController : UIViewController


//设置一个服务器
@property(nonatomic,strong)GCDAsyncSocket *server;

@end

