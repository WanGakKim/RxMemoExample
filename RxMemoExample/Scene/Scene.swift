//
//  Scene.swift
//  RxMemoExample
//
//  Created by Gak_ee on 2020/09/04.
//  Copyright © 2020 Gak_eee. All rights reserved.
//

import UIKit

enum Scene {
    case list(MemoListViewModel)
    case detail(MemoDetailViewModel)
    case compose(MemoComposeViewModel)
}

extension Scene {
    func instantiate(from storyboard: String = "Main") -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        
        switch self {
        case .list(let ViewModel):
            guard let nav = storyboard.instantiateViewController(withIdentifier: "ListNav") as? UINavigationController else {
                fatalError()
            }
            
            guard var listVC = nav.viewControllers.first as? MemoListViewController else {
                fatalError()
            }
            
            listVC.bind(viewModel: ViewModel)
            return nav
            
        case .detail(let viewModel):
            guard var detailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as? MemoDetailViewController else{
                fatalError()
            }
            
            detailVC.bind(viewModel: viewModel)
            
            return detailVC
        case .compose(let viewModel):
            guard let nav = storyboard.instantiateViewController(withIdentifier: "ListNav") as? UINavigationController else {
                fatalError()
            }
            
            guard var composeVC = storyboard.instantiateViewController(withIdentifier: "MemoComposeVC") as? MemoComposeViewController else{
                fatalError()
            }
            
            composeVC.bind(viewModel: viewModel)
            return nav
        }
    }
}