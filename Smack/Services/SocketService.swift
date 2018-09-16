//
//  SocketService.swift
//  Smack
//
//  Created by MatanHuja on 16/09/2018.
//  Copyright © 2018 Matan Huja. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {

    let manager = SocketManager(socketURL: URL(string: BASE_URL)!, config: [.compress, .log(true), .reconnects(false)])
    var socket : SocketIOClient
    
    static let instance = SocketService()
    
    override init() {
        self.socket = manager.defaultSocket
        super.init()
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler) {
        
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    
    func getChannel(completion: @escaping CompletionHandler) {
        socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else { return }
            guard let channelDesc = dataArray[1] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }
            
            let newChannel = Channel(_id: channelId, name: channelName, description: channelDesc, __v: 1)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
}
