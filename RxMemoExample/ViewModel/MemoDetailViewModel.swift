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
            memo.content,
            formatter.string(from: memo.insertDate)
        ])
        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage)
    }
    
    lazy var popAction = CocoaAction { [unowned self] in
        
        return self.sceneCoordinator.close(animated: true).asObservable().map{ _ in}
    }
    
    func performUpdate(memo: Memo) -> Action<String,Void> {
        return Action { input in
            self.storage.update(memo: memo, content: input).subscribe(onNext: { (updatedMemo) in
                self.contents.onNext([
                    updatedMemo.content,
                    self.formatter.string(from: updatedMemo.insertDate)
                ])
            }).disposed(by: self.rx.disposeBag)
            return Observable.empty()
        }
    }
    
    func makeEditAction() -> CocoaAction {
        return CocoaAction {
            _ in
            let composeViewModel = MemoComposeViewModel(title: "메모 편집", content: self.memo.content, sceneCoordinator: self.sceneCoordinator, storage: self.storage, saveAction: self.performUpdate(memo: self.memo))
            
            let composeSecne = Scene.compose(composeViewModel)
            return self.sceneCoordinator.transition(to: composeSecne, using: .modal, animated: true)
                .asObservable().map{ _ in}
        }
    }
    
    func makeDeleteAction() -> CocoaAction {
        return Action { input in
            self.storage.delete(memo: self.memo)
            return self.sceneCoordinator.close(animated: true).asObservable().map{ ß_ in }
        }
    }
}
