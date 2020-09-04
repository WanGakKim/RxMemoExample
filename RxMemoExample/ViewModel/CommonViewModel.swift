//
//  CommonViewModel.swift
//  RxMemoExample
//
//  Created by Gak_ee on 2020/09/04.
//  Copyright © 2020 Gak_eee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CommonViewModel: NSObject {
    let title: Driver<String>
    let sceneCorrdinator: SeceneCoordinatorType
    let storage: MemoStorageType
    
    init(title: String, sceneCoordinator : SeceneCoordinatorType, storage: MemoStorageType) {
        self.title = Observable.just(title)
            .asDriver(onErrorJustReturn: "")
        self.sceneCorrdinator = sceneCoordinator
        self.storage = storage
    }
}
