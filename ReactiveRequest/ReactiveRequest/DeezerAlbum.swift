//
//  DeezerAlbum.swift
//  ReactiveRequest
//
//  Created by Emilien Stremsdoerfer on 11/9/16.
//  Copyright © 2016 Emilien Stremsdoerfer. All rights reserved.
//

import Foundation
import RealmSwift

class DeezerAlbum : Object{
    
    dynamic var id = 0
    dynamic var title = ""
    dynamic var artist = ""
    let songs = List<DeezerSong>()
    
    
    static func from(json:Any) -> DeezerAlbum? {
        guard let json = json as? [String:Any] else {return nil}
        
        let album = DeezerAlbum()
        album.id = json["id"] as? Int ?? 0
        album.title = json["title"] as? String ?? ""
        album.artist = (json["artist"] as? [String:Any])?["name"] as? String ?? ""
        
        let jsonTracks = (json["tracks"] as? [String:Any])?["data"] as? [Any] ?? []
        let tracks = jsonTracks.flatMap({DeezerSong.from(json: $0)})
        tracks.forEach({album.songs.append($0)})
        
        return album
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
