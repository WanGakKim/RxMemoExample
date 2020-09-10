//
//  TransitionModel.swift
//  RxMemoExample
//
//  Created by Gak_ee on 2020/09/04.
//  Copyright © 2020 Gak_eee. All rights reserved.
//

import Foundation

enum TransitionStyle{
    case root
    case push
    case modal
}

enum TransitionError: Error{
    case navigationControllerMissing
    case connotPop
    case unknown
}
