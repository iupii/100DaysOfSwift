//
//  DetailViewController.swift
//  FirstMiddle
//
//  Created by Iurii Pachin on 2019/09/01.
//  Copyright © 2019 Iurii Pachin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedCountry: String?
    var selectedImage: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = self.selectedCountry?.uppercased()
        navigationItem.largeTitleDisplayMode = .never

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

        if let imageToLoad = selectedImage {
            self.imageView.image = UIImage(named: imageToLoad)
            // todo: fix image size
            self.imageView.layer.borderWidth = 1
            self.imageView.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        guard let image = self.imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}
