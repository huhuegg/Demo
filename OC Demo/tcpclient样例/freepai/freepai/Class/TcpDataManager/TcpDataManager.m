//
//  TcpDataManager.m
//  freepai
//
//  Created by admin on 14/6/17.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

/*
 Pai TCP数据代理，通过代理访问Pai TCP数据接口,获取数据
 */
#import "TcpDataManager.h"
#import "GCDAsyncSocket.h"
#import "adler32.h"

@implementation TcpDataManager

+(TcpDataManager *)instance {
    static TcpDataManager *instance = nil;
    /*
     dispatch_once_t 变量只是标识_dispatch_once的执行情况，当once已经被使用时，dispatch_once方法将不执行内容；
     */
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[TcpDataManager alloc]init];
    });
    return instance;
}

-(void)connServer {
    if (_socket.isConnected) {
        NSLog(@"socket is already connected! skip connServer operation!");
    } else {
        if (_socket) {
            _socket.delegate = nil;
            _socket = nil;
        }
        
        NSLog(@"socket initWithDelegate");
        //GCDAsyncSocket具有一系列完整的委托机制，我们所做的一切处理基本都是异步处理的状态，换句话说，连接之后是否连接成功，连接成功要执行什么懂并非应该写在此处而应该写在相应的委托之中，同样的道理一样适用于发送、读取数据等等。
        _socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        
        _buffer = [[NSMutableData alloc]init];
        _packLength=-1;
        _loopCheckPackTimes=0;
        
        NSError *err = nil;
        [_socket connectToHost:PAI_TCP_SERVER_IP onPort:PAI_TCP_SERVER_PORT error:&err];
        //[_socket connectToHost:@"222.73.60.153" onPort:16020 error:&err];
        if (err != nil)
        {
            // If there was an error, it's likely something like "already connected" or "no delegate set"
            NSLog(@"Connect Server %@:%i error: %@",PAI_TCP_SERVER_IP,PAI_TCP_SERVER_PORT,err);
        } else {
            
        }
        
        [_socket readDataWithTimeout:-1 tag:0];
    }
    
}

-(void)disconnServer {
    NSLog(@"disconnServer");
    [_socket disconnect];
}


-(void)sendMsgWithData:(NSData *)contextData cmd:(int)cmdCode ifName:(NSString *)ifName{
    if (contextData && cmdCode && ifName) {
        NSData *packData = [self packMsgData:contextData cmd:cmdCode ifName:ifName];
        NSLog(@"SEND: cmdCode:%i ifName:%@ context:%@",cmdCode,ifName,contextData);
        [_socket writeData:packData withTimeout:-1 tag:0];
    } else {
    }
    [_socket readDataWithTimeout:-1 tag:0];
    
}

-(NSMutableData *)packMsgData:(NSData *)bodyContextData cmd:(int)cmdCode ifName:(NSString *)ifName {
    //DataLength 4
    //TimeStamp 4
    //DefineType 4
    //BodyLength 4
    //CheckField 4
    //Name 32
    //Body *
    
    
    //Body
    NSData *bodyCmdData = [NSData dataWithBytes:&cmdCode length:sizeof(cmdCode)];
    NSMutableData *bodyData = [[NSMutableData alloc]init];
    [bodyData appendData:bodyCmdData];
    [bodyData appendData:bodyContextData];
    
    //Name
    NSMutableData *nameData = [[NSMutableData alloc]init];
    NSData *tmpNameData = [ifName dataUsingEncoding:NSUTF8StringEncoding];
    [nameData appendData:tmpNameData];
    int appendLength =0;
    if ([nameData length]<32) {
        appendLength = 32-[nameData length];
        NSMutableData *tmp = [[NSMutableData alloc]initWithLength:appendLength];
        [nameData appendData:tmp];
    }
    //NSLog(@"nameData length:%i",[nameData length]);
    
    
    //CheckField
    //int checkField = abs([bodyData adler32]);
    
    int checkField = adler32(100, (Byte *)[bodyData bytes], [bodyData length]);
    
    
    NSData *checkFieldData = [NSData dataWithBytes:&checkField length:sizeof(checkField)];
    //NSLog(@"checkFieldData length:%i",[checkFieldData length]);
    
    //BodyLength
    int bodyLength = [checkFieldData length] + [nameData length] + [bodyData length];
    //NSLog(@"#####bodyLength:%i",bodyLength);
    NSData *bodyLengthData = [NSData dataWithBytes:&bodyLength length:sizeof(bodyLength)];
    //NSLog(@"bodyLengthData length:%i",[bodyLengthData length]);
    
    //defineType
    int defineType=0x00000100;
    NSData *defineTypeData = [NSData dataWithBytes:&defineType length:sizeof(defineType)];
    //NSLog(@"defineTypeData length:%i",[defineTypeData length]);
    
    //TimeStamp
    NSDate* currentDate = [NSDate date];
    long timestamp = (long)[currentDate timeIntervalSince1970];
    NSData *timestampData = [NSData dataWithBytes:&timestamp length:sizeof(timestamp)];
    //NSLog(@"timestampData length:%i",[timestampData length]);
    
    //DataLength
    int dataLength = [timestampData length] + [defineTypeData length] + [bodyLengthData length] + [checkFieldData length] + [nameData length] + [bodyData length];
    //NSLog(@"#####dataLength:%i",dataLength);
    NSData *dataLengthData = [NSData dataWithBytes:&dataLength length:sizeof(dataLength)];
    //NSLog(@"dataLengthData length:%i",[dataLengthData length]);
    
    NSMutableData *packData = [[NSMutableData alloc]init];
    [packData appendData:dataLengthData];
    [packData appendData:timestampData];
    [packData appendData:defineTypeData];
    [packData appendData:bodyLengthData];
    [packData appendData:checkFieldData];
    [packData appendData:nameData];
    [packData appendData:bodyData];
    
    return packData;
}

-(NSData *)stringToData:(NSString *)str length:(int)length {
    NSData *strToData = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSData *data;
    if ([strToData length] <= length) {
        data = [self expandData:strToData length:length];
    } else {
        data = [strToData subdataWithRange:NSMakeRange(0, length)];
    }
    return data;
}

-(NSMutableData *)expandData:(NSData *)data length:(int)length {
    NSMutableData *newdata = [[NSMutableData alloc]initWithData:data];
    
    if ([data length]<length) {
        int appendLength = length-[data length];
        NSMutableData *append = [[NSMutableData alloc]initWithLength:appendLength];
        [newdata appendData:append];
    }
    return newdata;
}

// 将字典或者数组转化为JSON串
- (NSData *)encodeJson:(id)data{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length]>0 && error == nil){
        return jsonData;
    }else{
        // 转换错误
        return nil;
    }
}

// 将JSON串转化为字典或者数组
- (id)decodeJson:(NSData *)jsonData{
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        // 解析错误
        return nil;
    }
    
}

#pragma mark Delegate


//在成功连接服务器之后的委托方法
- (void)socket:(GCDAsyncSocket *)sender didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"Connect %@:%i ok!",host,port);
    //读取数据的方法，两个参数也略显简单，一个超时时间，如果你设置成-1则认为永不超时，而第二参数则是区别该次读取与其他读取的标志，通常我们在设计视图上的控件时也会有这样的一个属性就是tag。如果你做过web开发，那你应该知道Http标签上的id，如果你做过一些桌面级开发，你的控件或许有个id或者是index再或者是tag的属性来区别这些控件，没错此tag和彼tag功效基本一样。
    //这是异步返回的连接成功，
    [_socket readDataWithTimeout:-1 tag:0];
}

//服务器断开之后的委托方法
- (void)onSocketDidDisconnect:(GCDAsyncSocket *)sock
{
    NSLog(@"client onSocketDidDisconnect");
}


- (void)socket:(GCDAsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
    NSLog(@"client willDisconnectWithError:%@",err);
}

//写入的委托
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"sent data ok");
    /*
     if (tag == 1)
     NSLog(@"First request sent");
     else if (tag == 2)
     NSLog(@"Second request sent");
     */
    [sock readDataWithTimeout:-1 tag:0];
}

//读取的委托
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    if (data) {
        [_buffer appendData:data];
        [self checkBuffer];
    }
}

-(void)checkBuffer {
    //52
    //DataLength 4
    
    //TimeStamp 4
    //DefineType 4
    //BodyLength 4
    
    //CheckField 4
    //Name 32
    //Body *
    NSLog(@"buffLength:%i loopCheckPackTimes:%i",[_buffer length],_loopCheckPackTimes);
    while ([_buffer length] >= PAI_PACK_HEAD_LENGTH && _loopCheckPackTimes<PAI_MAX_LOOP_CHECK_PACK_TIMES) {
        if (_packLength < 0) { //get packLength
            NSData *dataLength = [_buffer subdataWithRange:NSMakeRange(0, 4)];
            int tmpPackLength;
            [dataLength getBytes:&tmpPackLength length:sizeof(tmpPackLength)];
            
            //超出有2种情况：
            //  第一种是发送端确实发送了超过约定长度限制的
            //  第二种是检查的数据包中描述数据长度的数据异常,导致将这4个字节转换为int时得到不可预知的结果
            if (tmpPackLength > PAI_MAX_DATA_LENGTH) {
                NSLog(@"发现异常长度");
                _buffer = [[NSMutableData alloc]init];
                _packLength=-1;
                _loopCheckPackTimes=0;
                break;
            } else {
                _packLength = tmpPackLength + 4;
            }
        }
        if ([_buffer length] >= _packLength) {
            [self readPackAndSetBuffer];
        } else {
            _loopCheckPackTimes=0;
            break;
        }
        _loopCheckPackTimes++;
    }
    _loopCheckPackTimes=0;
}

-(void)readPackAndSetBuffer {
    NSData *packData = [_buffer subdataWithRange:NSMakeRange(0, _packLength)];
    NSData *bufferData = [_buffer subdataWithRange:NSMakeRange(_packLength, [_buffer length]-_packLength)];
    [_buffer setData:bufferData];
    _packLength=-1;
    [self checkPack:packData];
}

-(void)checkPack:(NSData *)packData {
    //52
    //DataLength 4
    
    //TimeStamp 4
    //DefineType 4
    //BodyLength 4
    
    //CheckField 4
    //Name 32
    //Body *  => command 1 + context *
    
    NSData *timestampData = [packData subdataWithRange:NSMakeRange(4, 4)];
    long int timestamp;
    [timestampData getBytes:&timestamp length:sizeof(timestamp)];
    
    NSData *defineTypeData = [packData subdataWithRange:NSMakeRange(8, 4)];
    int defineType;
    [defineTypeData getBytes:&defineType length:sizeof(defineType)];
    
    NSData *bodyLengthData = [packData subdataWithRange:NSMakeRange(12, 4)];
    int bodyLength;
    [bodyLengthData getBytes:&bodyLength length:sizeof(bodyLength)];
    
    NSData *checkFieldData = [packData subdataWithRange:NSMakeRange(16, 4)];
    int checkField;
    [checkFieldData getBytes:&checkField length:sizeof(checkField)];
    
    NSData *nameData = [packData subdataWithRange:NSMakeRange(20, 32)];
    NSString *name = [[NSString alloc]initWithData:nameData encoding:NSUTF8StringEncoding];
    
    NSData *bodyData;
    bodyData = [packData subdataWithRange:NSMakeRange(52, [packData length]-52)];
    

    //check adler32
    if ([bodyData length]>0) {
        int recheckAdler32 = adler32(100,(Byte *)[bodyData bytes], [bodyData length]);
        if (checkField == recheckAdler32) {
            NSLog(@"[ADLER32    OK]RECV body recvAdler:%i rechecckAdler:%i ifName:%@ ",checkField,recheckAdler32,name);
            [self checkCmd:bodyData ifName:(NSString *)name];
        } else {
            NSLog(@"[ADLER32 ERROR]RECV body recvAdler:%i rechecckAdler:%i ifName:%@ ",checkField,recheckAdler32,name);
        }
    } else {
        NSLog(@"[WARN] no body!");
    }
}

-(void)checkCmd:(NSData *)bodyData ifName:(NSString *)name {
    NSData *returnCodeData;
    int returnCode = 0;
    NSData *bodyContextData;
    
    if ([bodyData length] == 4) { //只包含命令的body
        returnCodeData = [bodyData subdataWithRange:NSMakeRange(0, 4)];
        [returnCodeData getBytes:&returnCode length:sizeof(returnCode)];
        NSLog(@"RECV: ifName:%@ returnCode:%i cmdlength:%i contextlength:0",name,returnCode,[returnCodeData length]);
    } else {
        returnCodeData = [bodyData subdataWithRange:NSMakeRange(0, 4)];
        [returnCodeData getBytes:&returnCode length:sizeof(returnCode)];
        bodyContextData = [bodyData subdataWithRange:NSMakeRange(4, [bodyData length]-4)];
        name = [name stringByReplacingOccurrencesOfString:@"\0" withString:@""];
        NSLog(@"RECV: ifName:%@ returnCode:%i cmdlength:%i contextlength:%i",name,returnCode,[returnCodeData length],[bodyContextData length]);
        
        [self unpackCmd:(NSData *)bodyData ifName:(NSString *)name];
    }

    
}

-(void)unpackCmd:(NSData *)bodyData ifName:(NSString *)name {
    NSLog(@"unpackCmd  ifName:%@",name);
    if (name) {
        if ([name isEqualToString:NOTIFY_ERROR]) { //normal_error
            //struck
            normal_error errorRecv;
            
            NSValue *value = [NSValue valueWithBytes:[bodyData bytes] objCType:@encode(normal_error)];
            [value getValue:&errorRecv];
            
            int errorStatus = errorRecv.error_status;
            NSString *errorDesc = [[NSString alloc] initWithCString:(const char*)errorRecv.error_desc encoding:NSUTF8StringEncoding];
            
            NSLog(@"[RECV] NORMAL_ERROR: error_status:%i error_desc:%@",errorStatus,errorDesc);
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            [dict setValue:[[NSNumber alloc]initWithInt:errorStatus] forKey:@"error_status"];
            [dict setValue:errorDesc forKey:@"error_desc"];
            
            NSLog(@"Send postNotification: %@ with dict:%@",NOTIFY_ERROR,dict);
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_EXAMPLE object:dict];
        }
        if ([name isEqualToString:REQ_EXAMPLE_IFNAME]) {  //example_one
            //struck
            example_return exampleRecv;
            
            NSValue *value=[NSValue valueWithBytes:[bodyData bytes] objCType:@encode(example_return)];
            [value getValue:&exampleRecv];
            
            //get data
            int returnCode = exampleRecv.return_code;
            NSString *exampleResult = [[NSString alloc] initWithCString:(const char*)exampleRecv.example_result encoding:NSUTF8StringEncoding];

            NSLog(@"[RECV] ifname:%@ returnCode:%i result:%@",name,returnCode,exampleResult);
            
            
            //set dict
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            [dict setValue:[[NSNumber alloc]initWithInteger:returnCode] forKey:@"return_code"];
            [dict setValue:exampleResult forKey:@"example_result"];
            
            NSLog(@"Send postNotification: %@ with dict:%@",NOTIFY_EXAMPLE,dict);
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_EXAMPLE object:dict];
        }
    }
    
}
@end
