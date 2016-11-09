//
//  DeezerSong.swift
//  ReactiveRequest
//
//  Created by Emilien Stremsdoerfer on 11/9/16.
//  Copyright © 2016 Emilien Stremsdoerfer. All rights reserved.
//

import Foundation
import RealmSwift

class DeezerSong : Object{
    
    dynamic var id = 0
    dynamic var title = ""
    
    
    static func from(json:Any) -> DeezerSong?{
        guard let json = json as? [String:Any] else {return nil}
        let song = DeezerSong()
        song.id = json["id"] as! Int
        song.title = json["title"] as! String
        return song
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
