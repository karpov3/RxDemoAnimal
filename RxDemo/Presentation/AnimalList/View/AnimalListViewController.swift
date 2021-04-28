//
//  AnimalListViewController.swift
//  RxDemo
//
//  Created by Alexander Karpov on 27/04/21.
//

import UIKit
import RxSwift
import RxDataSources

class AnimalListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    // MARK: Rx
    
    let disposeBag = DisposeBag()
    
    // MARK: Initialization
    
    var viewModel: AnimalListViewModelling!
    
    public init(viewModel: AnimalListViewModelling) {
        super.init(nibName: "AnimalListViewController", bundle: Bundle(for: type(of: self)))
        self.viewModel = viewModel
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        _setupBindings()
    }
    
    func setupView() {
        tableView.register(UINib(nibName: "AnimalTableViewCell", bundle: nil), forCellReuseIdentifier: "AnimalTableViewCellReuseIdentifier")
    }

    func _setupBindings() {
        
        searchBar.rx
            .text
            .map{$0 ?? ""}
            .bind(to: viewModel.searchKey)
            .disposed(by: disposeBag)
        
        searchBar.rx.cancelButtonClicked
            .map{_ in ""}
            .bind(to: viewModel.searchKey)
            .disposed(by: disposeBag)
        
        viewModel.data
            .drive(tableView.rx.items(cellIdentifier: "AnimalTableViewCellReuseIdentifier", cellType: AnimalTableViewCell.self)) { index, model, cell in

                cell.name.text = model.name
                cell.animal.text = model.animal.rawValue
            }
            .disposed(by: disposeBag)

        viewModel.count
            .map{"Trovato: \($0)"}
            .drive(countLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.errorMessage.map{}
    }



}
