//
//  RecipeDetailViewController.swift
//  FoodRecipe
//
//  Created by Amir  on 10/2/20.
//  Copyright © 2020 Amir . All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class RecipeDetailViewController: UIViewController {
    
    let bag = DisposeBag()
    
    @IBOutlet weak var lblTags: UILabel!
    @IBOutlet weak var lblCalery: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var tagSectionView: UIView!
    
    lazy var viewModel: RecipeDetailViewModel = {
        return RecipeDetailViewModelImpl()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail"
        bind()
    }
    
    func bind() {
        viewModel.caleries.drive(self.lblCalery.rx.text).disposed(by: bag)
        viewModel.description.drive(self.lblDescription.rx.text).disposed(by: bag)
        viewModel.title.drive(self.lblTitle.rx.text).disposed(by: bag)
        //FIXME: can be changed with stack or collectionView 
        viewModel.tag.drive(self.lblTags.rx.text).disposed(by: bag)
        viewModel.isTagHidden.drive(self.tagSectionView.rx.isHidden).disposed(by: bag)
        viewModel.imageUrl.map { URL(string: $0 ?? "")}.drive(onNext: { (url) in
            guard let _url = url else {
                return
            }
            self.recipeImage.kf.setImage(with: _url)
        }).disposed(by: bag)
    }
}

extension RecipeDetailViewController {
    static func instance(for recipe: RecipeEntity) -> RecipeDetailViewController {
        let vc = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "RecipeDetailViewController") as! RecipeDetailViewController
        vc.viewModel.setEntity(recipe)
        return vc
    }
}
