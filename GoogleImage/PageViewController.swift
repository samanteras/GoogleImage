//
//  PageViewController.swift
//  GoogleImage
//
//  Created by MAC13 on 09.02.2023.
//

import UIKit
import SafariServices
import Kingfisher

class PageViewController: UIViewController {

    @IBOutlet weak var searchImage: UIImageView!
    @IBOutlet weak var pushBrowser: UIButton!
    var resultData: Result!
    var urlImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getImage(url: resultData.thumbnail, imageView: searchImage)
        if URL(string: resultData.link) == nil {
            pushBrowser.isHidden = true
        }
    }
    
    @IBAction func pushToOpenInBrowser(_ sender: Any) {
        if let url = URL(string: resultData.link) {
            let svc = SFSafariViewController(url:url)
            present(svc, animated: true)
        }
    }
    
    func getImage(url: String, imageView: UIImageView){
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = try? Data(contentsOf: url) {
                    let image = UIImage(data: data)
                    if image!.size.height > 100 && image!.size.width > 100 {
                        DispatchQueue.main.async {
                            imageView.kf.setImage(with: url)
                        }
                    } else {
                        DispatchQueue.main.async {
                            imageView.image = UIImage(named: "content")
                        }
                    }
                }
            }.resume()
        } else {
            DispatchQueue.main.async {
                imageView.image = UIImage(named: "content")
            }
        }
    }

}
