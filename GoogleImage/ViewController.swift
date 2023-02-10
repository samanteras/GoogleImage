//
//  ViewController.swift
//  GoogleImage
//
//  Created by MAC13 on 07.02.2023.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    let correctText = ""
    var index: Int = 0
   
    

    @IBOutlet weak var searcher: UISearchBar!
    @IBOutlet weak var collectionImages: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("index View: \(indexForImage.indexMain)")
        self.collectionImages.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        self.collectionImages.dataSource = self
        self.collectionImages.delegate = self
        
    }
    
    func urlEncode(string: String) -> String {
        let allowedCharacterSet = CharacterSet.alphanumerics.union(CharacterSet(charactersIn: "-._~"))
        return string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)!
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searcher.resignFirstResponder()
        if let text = searcher.text {
            let correctText = urlEncode(string: text)
            results = []
            collectionImages?.reloadData()
            request(query: correctText) {
                self.collectionImages.reloadData()
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionImages.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        let imageURLString = results[indexPath.row].thumbnail
        
        cell.configure(with: imageURLString)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let page = storyboard?.instantiateViewController(withIdentifier: "PageStoryboard") as! PageViewController
        let single = storyboard?.instantiateViewController(withIdentifier: "SingleImageStoryboard") as! SingleImageViewController
        indexForImage.indexMain = indexPath.row
        single.resultData = results[indexPath.row]
        single.indexSingle = indexPath.row
        print("index View: \(indexForImage.indexMain)")
        single.correctText = correctText
        self.collectionImages.reloadData()
        self.navigationController?.pushViewController(page, animated: true)
    }
    
}

