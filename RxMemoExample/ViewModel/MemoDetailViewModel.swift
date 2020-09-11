//
//  MemoDetailViewModel.swift
//  RxMemoExample
//
//  Created by Gak_ee on 2020/09/04.
//  Copyright © 2020 Gak_eee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class MemoDetailViewModel : CommonViewModel{
    let memo: Memo
    
    private var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "Ko_kr")
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }()
    
    var contents: BehaviorSubject<[String]> // 메모를 편집하고 나서 메모가 편집 후에 반영되어야 함. 옵저버블로 하면 안됨.
    
    init(memo: Memo, title: String, sceneCoordinator: SeceneCoordinatorType, storage: MemoStorageType) {
        self.memo = memo
        
        contents = BehaviorSubject<[String]>(value: [
            memo.content
            formatter.string(from: memo.insertDate)
        ])
        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage)
    }
}
