//
//  MemoListViewModel.swift
//  RxMemoExample
//
//  Created by Gak_ee on 2020/09/04.
//  Copyright © 2020 Gak_eee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Action
import RxDataSources
/**
 목록화면 상단 + 버튼
 이 버튼을 탭하면 쓰기화면을 모달방식으로 표현
**/

typealias MemoSectionModel = AnimatableSectionModel<Int, Memo>



class MemoListViewModel : CommonViewModel{
    
    
    var memoList: Observable<[MemoSectionModel]> {
           return storage.memoList()
       }
    // RxDataSource
    let dataSource: RxTableViewSectionedAnimatedDataSource<MemoSectionModel> = {
        let ds = RxTableViewSectionedAnimatedDataSource<MemoSectionModel>.init(configureCell: { (dataSource, tableView, indexPath, item) -> UITableViewCell in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            cell.textLabel?.text = item.content
            return cell
        })
        ds.canEditRowAtIndexPath = { _,_ in return true}
        return ds
    }()
    
    func performUpdate(memo: Memo) -> Action<String,Void> {
        return Action { input in
            return self.storage.update(memo: memo, content: input).map{ _ in }
        }
    }
    
    func performCancel(memo: Memo) -> CocoaAction {
        return Action {
            return self.storage.delete(memo: memo).map{ _ in}
        }
    }
    
    func makeCreateAction() -> CocoaAction {
        return CocoaAction { _ in
            
            return self.storage.createMemo(content: "")
                .flatMap { (memo) -> Observable<Void> in
                    let composeViewModel = MemoComposeViewModel(title: "새 메모",
                                                                sceneCoordinator: self.sceneCoordinator,
                                                                storage: self.storage,
                                                                saveAction: self.performUpdate(memo: memo),
                                                                cancelAction: self.performCancel(memo: memo))
                    let composeScene = Scene.compose(composeViewModel)
                    return self.sceneCoordinator.transition(to: composeScene, using: .modal , animated: true).asObservable().map { _ in }
            }
        }
    }
     
    lazy var detailAction: Action<Memo, Void> = {
        return Action { memo in
            
            let detailViewModel = MemoDetailViewModel(memo: memo, title: "메모 보기", sceneCoordinator: self.sceneCoordinator, storage: self.storage)
            
            let detailScene = Scene.detail(detailViewModel)
            
            return self.sceneCoordinator.transition(to: detailScene, using: .push, animated: true).asObservable().map{_ in}
            
        }
    }()
    
    
    lazy var deleteAction: Action<Memo, Swift.Never> = {
        return Action { memo in
            return self.storage.delete(memo: memo).ignoreElements()
        }
    }()
    
}
