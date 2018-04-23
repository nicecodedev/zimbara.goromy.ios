//
//  TutorialController.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 10.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import UIKit

class TutorialController: UIViewController {

    @IBOutlet weak var tutorialCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var nextButton: GradientButton!
    @IBOutlet weak var startButton: GradientButton!
    
    private var current: Int = 0
    private var images: Array<UIImage> = [ #imageLiteral(resourceName: "tutorial_image_0"), #imageLiteral(resourceName: "tutorial_image_1"), #imageLiteral(resourceName: "tutorial_image_2")]
    private var texts: Array<String> = [
        "Всемирный проект помощи детям",
        "Иллюстрации художников и детей",
        "Захватывающая история"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tutorialCellNib = UINib(nibName: "TutorialCollectionCell", bundle: nil)
        tutorialCollectionView?.register(tutorialCellNib, forCellWithReuseIdentifier: "tutorialCell")
        
        tutorialCollectionView.delegate = self
        tutorialCollectionView.dataSource = self
    }
    
    @IBAction func next(_ sender: GradientButton) {
        print("go next")
        current = current + 1
        
        if current < 3 {
            pageControl?.currentPage = current
            let indexPath = IndexPath(row: current, section: 0)
            tutorialCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        } else {
            skip(self)
        }
        
        if current > 1 {
            nextButton.isHidden = true
            startButton.isHidden = false
        }
    }
    
    @IBAction func skip(_ sender: Any) {
        print("skip")
        UIApplication.shared.changeController(to: MainMenuContainerController.self)
    }
    
}

extension TutorialController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tutorialCell", for: indexPath) as! TutorialCollectionCell
        cell.tutorialImage = images[indexPath.row]
        cell.tutorialText = texts[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
}
