//
//  SocketServer.swift
//  SocketServer
//
//  Created by 李伟 on 16/4/21.
//  Copyright © 2016年 Jasoooon. All rights reserved.
//

import Foundation
import CoreFoundation

class SocketServer: NSObject ,NSStreamDelegate{
    var inputStream:NSInputStream?
    var outputStream:NSOutputStream?
    
    lazy var _chatMsgsArray:NSMutableArray = []
    
    func stream(aStream: NSStream, handleEvent eventCode: NSStreamEvent) {
        switch eventCode {
        case NSStreamEvent.OpenCompleted:
            print("输入输出打开完成")
            break;
        case NSStreamEvent.HasBytesAvailable:
            
            break;
        case NSStreamEvent.HasSpaceAvailable:
            
            break;
        case NSStreamEvent.ErrorOccurred:
            
            break;
        case NSStreamEvent.EndEncountered:
            inputStream?.close()
            outputStream?.close()
            inputStream?.removeFromRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
            outputStream?.removeFromRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
            break;
        default:
            break;
        }
    }
    
    func ConnectToHost(){
        let host:String = "127.0.0.1"
        let port:UInt32 = 12345
        
        var readStream:Unmanaged<CFReadStreamRef>?
        var writeStream:Unmanaged<CFWriteStreamRef>?
        CFStreamCreatePairWithSocketToHost(nil, host, port, &readStream, &writeStream)
        
        inputStream = readStream?.takeUnretainedValue()
        outputStream = writeStream?.takeUnretainedValue()
        
        inputStream?.delegate = self
        outputStream?.delegate = self
        
        inputStream?.scheduleInRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
        outputStream?.scheduleInRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
        
        inputStream?.open()
        outputStream?.open()
        
        print("connect")
        
    }
    
    func loginServer(){
        let loginStr = "Iam:Jasoooon"
        let data:NSData = loginStr.dataUsingEncoding(NSUTF8StringEncoding)!
        outputStream?.write(UnsafePointer<UInt8>(data.bytes), maxLength: data.length)
    }
    
}
