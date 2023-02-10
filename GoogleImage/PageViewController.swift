//
//  PageViewController.swift
//  GoogleImage
//
//  Created by MAC13 on 09.02.2023.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var indexMain = indexForImage.indexMain
    var correctText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("index Page 1: \(indexForImage.indexMain)")
        
        if let vc = self.pageViewController(for: indexForImage.indexMain) {
            self.setViewControllers([vc], direction: .forward, animated: false)
        }
    //request(query: correctText){
//        DispatchQueue.main.async {
            
       // }
        
        self.dataSource = self

    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        print("index Page 2: \(indexForImage.indexMain)")
        indexForImage.indexMain -= 1
        if indexForImage.indexMain < 0 {
            indexForImage.indexMain += 1
            return nil
        } else {
            return self.pageViewController(for: indexForImage.indexMain)

        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        print("index Page 3: \(indexForImage.indexMain)")
        indexForImage.indexMain +=  1
        if indexForImage.indexMain >= results.count {
            indexForImage.indexMain -= 1
            return nil
        } else {
                return self.pageViewController(for: indexForImage.indexMain)
            }
    }
    
    func pageViewController(for index: Int) -> SingleImageViewController? {
        if index < 0 {
            return nil
        }
        
        if index >= results.count {
            return nil
        }
        
        let single = storyboard?.instantiateViewController(withIdentifier: "SingleImageStoryboard") as! SingleImageViewController
        print("index Page 4: \(indexForImage.indexMain)")

        single.resultData = results[index]
        single.correctText = correctText
        
      
        
        return single
    }

}
