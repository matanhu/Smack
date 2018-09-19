//
//  NessageService.swift
//  Smack
//
//  Created by MatanHuja on 15/09/2018.
//  Copyright © 2018 Matan Huja. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    static let instance = MessageService()
    
    var channels = [Channel]()
    var messages = [Message]()
    var selectedChannel : Channel?
    
    func findAllChannel(completion: @escaping CompletionHandler) {
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                
                do {
                    self.channels = try JSONDecoder().decode([Channel].self, from: data)
                    NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                    completion(true)
                } catch {
                    debugPrint(error as Any)
                    completion(false)
                }
                
                
//                if let json = JSON(data).array {
//                    for item in json {
//                        let name = item["name"].stringValue
//                        let channelDescription = item["description"].stringValue
//                        let id = item["_id"].stringValue
//                        let channel = Channel(channelTitle: name, chnnelDescription: channelDescription, id: id)
//                        self.channels.append(channel)
//                    }
//
//                    completion(true)
//                }
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }

    func findAllMessagesForChannel(channelId: String, completion: @escaping CompletionHandler) {
        Alamofire.request(URL_GET_MESSAGES, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                self.clearMessages()
                guard let data = response.data else { return }
                do {
                    if let json = try JSON(data: data).array {
                        for item in json {
                            let messageBody = item["messageBody"].stringValue
                            let channelId = item["channelId"].stringValue
                            let id = item["_id"].stringValue
                            let userName = item["userName"].stringValue
                            let userAvatar = item["userAvatar"].stringValue
                            let userAvatarColor = item["userAvatarColor"].stringValue
                            let timeStamp = item["timeStamp"].stringValue
                            
                            let message = Message(message: messageBody, userName: userName, channeId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                            self.messages.append(message)
                        }
                        completion(true)
                    } else {
                        print("if let json = try JSON(data: data).array return false")
                        completion(false)
                    }
                } catch {
                    debugPrint("\(error)")
                    completion(false)
                }
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
    func clearMessages() {
        messages.removeAll()
    }
    
    func clearChannels() {
        channels.removeAll()
    }

    
}
