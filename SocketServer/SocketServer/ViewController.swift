//
//  ViewController.swift
//  SocketServer
//
//  Created by 李伟 on 16/4/21.
//  Copyright © 2016年 Jasoooon. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var msgTableView: NSScrollView!
    
    var socketServer:SocketServer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SocketServer"
        socketServer = SocketServer()

        // Do any additional setup after loading the view.
    }

    @IBAction func StartServer(sender: AnyObject) {
        socketServer?.ConnectToHost()
        socketServer?.loginServer()
    }
    @IBAction func StopServer(sender: AnyObject) {
    }
    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

