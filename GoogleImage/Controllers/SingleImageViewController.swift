//
//  PageViewController.swift
//  GoogleImage
//
//  Created by MAC13 on 09.02.2023.
//

import UIKit
import SafariServices
import Kingfisher

class SingleImageViewController: UIViewController {

    var indexSingle: Int = 0
    var correctText = ""

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
}
