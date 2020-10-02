//
//  ViewController.swift
//  FoodRecipe
//
//  Created by Amir  on 10/1/20.
//  Copyright © 2020 Amir . All rights reserved.
//

import UIKit
import RxSwift
import Contentful
import RxCocoa

class RecipeListViewController : UIViewController {
    
    let bag = DisposeBag()
    lazy var viewModel: RecipeListViewModel = { [unowned self] in
        return RecipeListViewModelImpl(repositry: ContentfulRecipeRepocitory())
        }()
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
            tableView.register(UINib(nibName: "RecipeCell", bundle: nil), forCellReuseIdentifier: "RecipeCell")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Recipes"
        bind()
    }
    
    func bind() {
        
        self.viewModel.getList().drive(tableView.rx.items(cellIdentifier: "RecipeCell",
                                                          cellType: RecipeCell.self))
        {(index, repository, cell) in
            cell.config(by: repository)
        }.disposed(by: bag)
        
        self.viewModel.navigateToDetailWith.subscribe(onNext: { (entity) in
        //FIXME: we can impliment navigator or interceptor to handel navigation
            let vc = RecipeDetailViewController.instance(for: entity)
            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: bag)
        

        self.tableView.rx.itemSelected.subscribe(onNext: self.viewModel.select(on:)).disposed(by: bag)
        
    }
}

