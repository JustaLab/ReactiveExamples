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
    
}

extension Observable where Element : Object {
    
    func makeLocal() -> Observable<Element> {
        return self.flatMapLatest({ (element) -> Observable<Element> in
            let realm = try! Realm()
            try! realm.write({
                realm.add(element, update: true)
            })
            return Observable.from(element)
        })
    }
    
}
