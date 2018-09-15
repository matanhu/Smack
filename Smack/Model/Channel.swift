//
//  Channel.swift
//  Smack
//
//  Created by MatanHuja on 15/09/2018.
//  Copyright © 2018 Matan Huja. All rights reserved.
//

import Foundation

//struct Channel {
//    public private(set) var channelTitle: String!
//    public private(set) var chnnelDescription: String!
//    public private(set) var id: String!
//}

struct Channel : Decodable {
    public private(set) var _id: String!
    public private(set) var name: String!
    public private(set) var description: String!
    public private(set) var __v: Int?
}
