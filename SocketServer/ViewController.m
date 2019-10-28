//
//  ViewController.m
//  SocketServer
//
//  Created by lfc on 2019/10/15.
//  Copyright © 2019 lfc. All rights reserved.
//

#import "ViewController.h"
#import "GCDAsyncSocket.h"
#import "SocketManager.h"

//遵守协议
@interface ViewController ()<GCDAsyncSocketDelegate>
@property (weak, nonatomic) IBOutlet UITextField *portNumber;
@property (weak, nonatomic) IBOutlet UIButton *portBut;
@property (weak, nonatomic) IBOutlet UITextView *sendTextView;
@property (weak, nonatomic) IBOutlet UITextView *receiveTextView;


//给一个数组存clientSocket
//@property(nonatomic,strong)NSMutableArray *clientArrsSocket;

//
//@property (strong, nonatomic)GCDAsyncSocket * serverSocket;

//
@property (strong, nonatomic)GCDAsyncSocket * clientSocket;

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


//客户端socket数组
//- (NSMutableArray *)clientArrsSocket
//{
//    if(_clientArrsSocket == nil)
//    {
//        _clientArrsSocket = [NSMutableArray array];
//    }
//    return _clientArrsSocket;
//}

//创建服务器连接管道
//get方法
- (GCDAsyncSocket *)server
{
    if(_server == nil)
    {
        _server = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    return _server;
}

//监听并绑定
- (IBAction)listenToSocket:(id)sender {
       
       NSError * error = nil;
       [self.server acceptOnPort:[self.portNumber.text integerValue] error:&error];
    
       NSLog(@"server = %@",self.server);
}

//服务器发送消息到客户端
- (IBAction)sendMessage:(id)sender {

    
    [self.clientSocket writeData:[self.sendTextView.text dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];

    //SocketManager * socketManager = [SocketManager sharedSocketManager];
    //[socketManager.mySocket readDataWithTimeout:-1 tag:0];
}

//接收消息到服务器
- (IBAction)receiveMassage:(id)sender {
    
    [self.clientSocket readDataWithTimeout:-1 tag:0];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

//通过代理告诉连接

- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket
{
    //连接成功，可查看newSocket.connectedHost和newSocket.connectedPort等参数
    self.portBut.enabled = NO;
    self.clientSocket = newSocket;
    NSLog(@"clientSocket = %@",newSocket);
}

//读数据

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    
    NSString * receive = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    self.receiveTextView.text = [NSString stringWithFormat:@"%@\n%@",self.receiveTextView.text,receive];
}


//是否连接
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err;
{
    NSLog(@"连接失败");
    //self.listenPortBtn.enabled = NO;
}


- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"%ld",tag);
}

@end
