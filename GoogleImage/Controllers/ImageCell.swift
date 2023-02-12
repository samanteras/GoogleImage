//
//  ImageCell.swift
//  GoogleImage
//
//  Created by MAC13 on 08.02.2023.
//

import UIKit

class ImageCell: UICollectionViewCell {

    @IBOutlet weak var googleImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(with urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data:data)
                self?.googleImage.image = image
            }
        }.resume()
    }
}
