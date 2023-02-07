//
//  ViewController.swift
//  GoogleImage
//
//  Created by MAC13 on 07.02.2023.
//

import UIKit

class ViewController: UIViewController {

    var images_results: [Result] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        request()
        
    }
    
    func request(){
        guard let url = URL(string: "https://serpapi.com/search.json?q=Apple&tbm=isch&ijn=0") else {
            return
        }
     //   guard let self = self else { return }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
        
            guard let data = data, error == nil  else {
                return
            }
            
            do {
                let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)
                DispatchQueue.main.async {
                    self.images_results = jsonResult.images_results
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


