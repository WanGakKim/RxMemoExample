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

class MemoListViewModel : CommonViewModel{
    var memoList: Observable<[Memo]> {
        return storage.memoList()
    }
}
