//
//  DeezerService.swift
//  ReactiveRequest
//
//  Created by Emilien Stremsdoerfer on 11/9/16.
//  Copyright © 2016 Emilien Stremsdoerfer. All rights reserved.
//

import Foundation
import RxSwift
import Nikka

struct DeezerProvider:HTTPProvider{
    var baseURL = URL(string:"https://api.deezer.com/")!
}

extension Route{
    static let album = {(id:Int) in Route(path:"/album/\(id)}") }
}

class DeezerService{
    
    let provider = DeezerProvider()
    
    
    func album(id:Int) -> Observable<Any>{
        return provider.request(.album(id)).responseJSON()
    }
    
}
