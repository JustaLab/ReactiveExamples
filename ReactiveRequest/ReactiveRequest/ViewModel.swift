//
//  ViewModel.swift
//  ReactiveRequest
//
//  Created by Emilien Stremsdoerfer on 11/9/16.
//  Copyright © 2016 Emilien Stremsdoerfer. All rights reserved.
//

import Foundation
import RxSwift

class ViewModel{
    
    let realmManager:RealmManager
    let service:DeezerService
    
    let albumSubj = PublishSubject<DeezerAlbum?>()
    
    let bag = DisposeBag()
    
    init(realmManager:RealmManager, service:DeezerService){
        self.realmManager = realmManager
        self.service = service
    }
    
    func setup(reloadTap:Observable<Void>){
        
        reloadTap
            .debounce(0.5, scheduler: MainScheduler.instance)
            .flatMapLatest { _ -> Observable<Any> in
                self.service.album(id: Int(arc4random_uniform(1000000)))
            }
            .map({DeezerAlbum.from(json: $0)})
            .filter({$0 != nil}).map({$0!})
            //.flatMap({ self.realmManager.makeLocal(album: $0) })
            .bindTo(albumSubj)
            .addDisposableTo(bag)
    }
    
}
