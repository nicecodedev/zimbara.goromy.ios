//
//  BookInfoController.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 03.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import UIKit

class BookInfoController: UIViewController {

    @IBOutlet weak var infoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let bookImagesCellNib = UINib(nibName: "BookImagesCell", bundle: nil)
        infoTableView.register(bookImagesCellNib, forCellReuseIdentifier: "bookImagesCell")
        
        let bookTitleCellNib = UINib(nibName: "BookTitleCell", bundle: nil)
        infoTableView.register(bookTitleCellNib, forCellReuseIdentifier: "bookTitleCell")
        
        let buyBookCellNib = UINib(nibName: "BookBuyCell", bundle: nil)
        infoTableView.register(buyBookCellNib, forCellReuseIdentifier: "buyCell")
        
        let bookAnnotationCellNib = UINib(nibName: "BookAnnotationCell", bundle: nil)
        infoTableView.register(bookAnnotationCellNib, forCellReuseIdentifier: "annotationCell")
        
        infoTableView.delegate = self
        infoTableView.dataSource = self
    }

    func openAuth() {
        let signInController: LoginSignInController = UIViewController.from(LoginSignInController.self)
        signInController.modalTransitionStyle = .crossDissolve
        signInController.modalPresentationStyle = .overFullScreen
        present(signInController, animated: true)
    }
}

extension BookInfoController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return [dequeueBookImagesCell,
                dequeueBookTitleCell,
                dequeueBuyCell,
                dequeueAnnotationCell][indexPath.section](tableView, indexPath)
    }
    
    func dequeueBookImagesCell(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookImagesCell", for: indexPath)
        
        return cell
        
    }
    
    func dequeueBookTitleCell(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookTitleCell", for: indexPath) as! BookTitleCell
        return cell
    }
    
    func dequeueBuyCell(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "buyCell", for: indexPath) as! BookBuyCell
        cell.delegate = self
        return cell
    }
 
    func dequeueAnnotationCell(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "annotationCell", for: indexPath) as! BookAnnotationCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
        case (0, 0): return tableView.frame.width * 1.3
        default: return UITableViewAutomaticDimension
        }
    }
    
}

extension BookInfoController: BuyBookCellDelegate {
    
    func buyBookCell(buyPressedFor buyBookCell: BookBuyCell) {
        openAuth()
    }
    
}
