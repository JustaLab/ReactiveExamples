//
//  ViewController.swift
//  ReactiveRequest
//
//  Created by Emilien Stremsdoerfer on 11/9/16.
//  Copyright © 2016 Emilien Stremsdoerfer. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import RealmSwift

class ViewController: UIViewController {

    let vm:ViewModel
    let bag = DisposeBag()
    
    let artistLabel = UILabel()
    let albumLabel = UILabel()
    let reloadButton = UIButton()
    let tableView = UITableView()
    
    init(viewModel:ViewModel){
        self.vm = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(artistLabel)
        self.view.addSubview(albumLabel)
        self.view.addSubview(reloadButton)
        self.view.addSubview(tableView)
        
        artistLabel.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(reloadButton.snp.bottom)
            make.height.equalTo(40)
        }
        
        albumLabel.snp.makeConstraints { make in
            make.top.equalTo(artistLabel.snp.bottom)
            make.height.equalTo(40)
            make.left.equalTo(10)
        }
        
        reloadButton.setTitle("Reload", for: .normal)
        reloadButton.setTitleColor(.black, for: .normal)
        reloadButton.layer.borderWidth = 2
        reloadButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(64)
            make.width.equalTo(100)
        }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.snp.makeConstraints { make in
            make.top.equalTo(albumLabel.snp.bottom).offset(40)
            make.left.right.bottom.equalTo(0)
        }
        
        self.vm.setup(reloadTap: reloadButton.rx.tap.asObservable())
        
        
        vm.albumSubj.map({"Artist: \($0!.artist)"}).bindTo(artistLabel.rx.text).addDisposableTo(bag)
        vm.albumSubj.map({"Album: \($0!.title)"}).bindTo(albumLabel.rx.text).addDisposableTo(bag)
        
        vm.albumSubj.map({Array($0!.songs)}).bindTo(tableView.rx.items(cellIdentifier: "UITableViewCell")) { (index, song: DeezerSong, cell) in
            cell.textLabel?.text = song.title
        }.addDisposableTo(bag)
        
        vm.albumSubj.subscribe { (event) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                if let album = event.element{
                    try! Realm().write({
                        album?.artist = "Blahhh"
                    })
                }
            }
            
        }.addDisposableTo(bag)
    }
}

