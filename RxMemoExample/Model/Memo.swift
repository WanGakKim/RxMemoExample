//
//  Memo.swift
//  RxMemoExample
//
//  Created by Gak_ee on 2020/09/03.
//  Copyright © 2020 Gak_eee. All rights reserved.
//

import Foundation
import RxDataSources // tableview와 collectionView에 binding 할 수 있습니다

struct Memo: Equatable, IdentifiableType{
    var content: String
    var insertDate: Date
    var identity: String
    
    init(content: String, insertDate: Date = Date()) {
        self.content = content
        self.insertDate = insertDate
        self.identity = "\(insertDate.timeIntervalSinceReferenceDate)"
    }
    
    //New instance Method
    init(original: Memo, updatedContent: String){
        self = original
        self.content = updatedContent
    }
}
