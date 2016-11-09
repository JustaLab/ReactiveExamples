//
//  RealmManager.swift
//  ReactiveRequest
//
//  Created by Emilien Stremsdoerfer on 11/9/16.
//  Copyright © 2016 Emilien Stremsdoerfer. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import RxRealm

class RealmManager{
    
    func makeLocal(album:DeezerAlbum) -> Observable<DeezerAlbum>{
        let realm = try! Realm()
        try! realm.write({
            realm.add(album, update: true)
        })
        
        let object = realm.object(ofType: DeezerAlbum.self, forPrimaryKey: album.id)
        
        return Observable.from(object!)
    }
}
