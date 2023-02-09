//
//  ViewController.swift
//  GoogleImage
//
//  Created by MAC13 on 07.02.2023.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {

    var results: [Result] = []
    
    @IBOutlet weak var searcher: UISearchBar!
    @IBOutlet weak var collectionImages: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            request(query: correctText)
        }
    }
    
    func request(query: String){
        let urlString = "https://serpapi.com/search.json?q=\(query)&tbm=isch&ijn=0&api_key=32fa08bae875f81fc73f39f36166330a256838d92051819dda4bfa11fb861620"
        guard let url = URL(string: urlString) else {
            return
        }
     //   guard let self = self else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                
            guard let data = data, error == nil  else {
                return
            }
            
            do {
                let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.results = jsonResult.images_results
                    self?.collectionImages.reloadData()
                }
                print(jsonResult.images_results.count)
            }
            catch {
                print(error)
            }
        }
        task.resume()
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
        let page = storyboard?.instantiateViewController(withIdentifier: "PageViewController") as! PageViewController
        page.resultData = results[indexPath.row]
        self.collectionImages.reloadData()
        self.navigationController?.pushViewController(page, animated: true)
    }
    
}

