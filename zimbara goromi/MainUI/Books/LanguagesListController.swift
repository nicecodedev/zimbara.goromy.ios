//
//  LanguagesListController.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 03.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import UIKit

class LanguagesListController: UIViewController {
    
    @IBOutlet weak var languagesTableView: UITableView!
    
    var presenter: iLanguagesListPresenter = LanguagesListPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.view = self

        let languageCellNib = UINib(nibName: "LanguageCell", bundle: nil)
        languagesTableView.register(languageCellNib, forCellReuseIdentifier: "languageCell")
        
        languagesTableView.delegate = self
        languagesTableView.dataSource = self
        
        presenter.fetchLanguages()
    }

}

protocol LanguagesListView: class {
    func reloadList()
}

extension LanguagesListController: LanguagesListView {
    func reloadList() {
        languagesTableView?.reloadData()
//        languagesTableView?.reloadSections([0], with: .automatic)
    }
}

extension LanguagesListController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectLanguage(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.languagesTotal
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "languageCell", for: indexPath) as! LanguageCell
        let (name, image, isCurrent) = presenter.language(at: indexPath.row)
        cell.name = name
        cell.flagImage = image
        cell.isCurrent = isCurrent
        return cell
    }
    
}
