//
//  ErrorReportController.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 12.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import UIKit

class ErrorReportController: UIViewController {

    @IBOutlet weak var errrorView: UIView!
    @IBOutlet weak var errorTextView: UITextView!
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var imagesCollectionHeightConstraint: NSLayoutConstraint!
    
    var presenter: iErrorReportPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = ErrorReportPresenter()
        presenter?.view = self

        errrorView?.clipsToBounds = true
        errrorView?.layer.cornerRadius = 7
        errrorView?.layer.borderWidth = 1
        errrorView?.layer.borderColor = RGB_A(223, 223, 223, ALPHA: 1).cgColor
        
        imagesCollectionHeightConstraint?.constant = 0
        
        let imageCellNib = UINib(nibName: "ErrorImageCollectionCell", bundle: nil)
        imagesCollectionView?.register(imageCellNib, forCellWithReuseIdentifier: "imageCell")
        
        imagesCollectionView?.delegate = self
        imagesCollectionView?.dataSource = self
        
    }
    
    private func showSelectImageAlert(sourceType: UIImagePickerControllerSourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = sourceType
        imagePickerController.delegate = self
        present(imagePickerController, animated: true)
    }
    
    @IBAction func addPhoto(_ sender: Any) {
        let alert = AlertController.newAlert
        alert.set(style: .rows)
        alert.addAction(withTitle: "Камера", tag: 0, ansStyle: .normal)
        alert.addAction(withTitle: "Галерея", tag: 1, ansStyle: .normal)
        alert.set(message: "Выберите источник фото")
        alert.delegate = self
        present(alert, animated: true)
    }

}

protocol ErrorReportView: class {
    func reloadImages()
}

extension ErrorReportController: ErrorReportView {
    func reloadImages() {
        imagesCollectionHeightConstraint?.constant = presenter?.totalImages == 0 ? 0 : 70
        imagesCollectionView?.layoutSubviews()
        imagesCollectionView?.reloadData()
    }
}

extension ErrorReportController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let total = presenter?.totalImages ?? 0
        print("total: \(total)")
        return total
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ErrorImageCollectionCell
        cell.delegate = self
        cell.image = presenter?.image(atIndex: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(3, 8, 3, 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 64, height: 64)
    }
}

extension ErrorReportController: ErrorImageCollectionCellDelegate {
    func deleteImage(_ errorImageCollectionCell: ErrorImageCollectionCell) {
        if let indexPath = imagesCollectionView?.indexPath(for: errorImageCollectionCell) {
            print(indexPath)
            presenter?.removeImage(atIndex: indexPath.row)
        } else {
            print("can't recognize")
        }
    }
}

extension ErrorReportController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            presenter?.add(image: image)
        }
        picker.dismiss(animated: true)
    }
    
}

extension ErrorReportController: AlertControllerDelegate {
    func alertController(didSelectActionWithTag tag: Int) {
        showSelectImageAlert(sourceType: tag == 0 ? .camera : .photoLibrary)
    }
}

