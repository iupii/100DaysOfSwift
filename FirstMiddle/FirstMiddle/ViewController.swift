//
//  ViewController.swift
//  FirstMiddle
//
//  Created by Iurii Pachin on 2019/09/01.
//  Copyright © 2019 Iurii Pachin. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    struct Flag {
        let country: String
        let image2x: String
        let image3x: String
        
        init(_ country: String, _ image2x: String, _ image3x: String) {
            self.country = country
            self.image2x = image2x
            self.image3x = image3x
        }
    }

    var flags = [Flag]()


    override func viewDidLoad() {
        super.viewDidLoad()

        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)

        var f2x = [String: String]()
        var f3x = [String: String]()

        for item in items {
            let country = String(item.dropLast(7))
            let suffix = item.suffix(7)
            if suffix == "@2x.png" {
                f2x[country] = item
            }
            if suffix == "@2x.png" {
                f3x[country] = item
            }
        }
        for item in f2x {
            if f3x[item.key] != nil {
                self.flags.append(Flag(item.key, item.value, f3x[item.key]!))
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.flags.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath) as! FlagViewCell
        let flag = self.flags[indexPath.row]
        cell.flagImageView?.image = UIImage(named: flag.image2x)
        cell.flagTextLabel?.text = "\(flag.country)"
        cell.flagImageView?.layer.borderWidth = 1
        cell.flagImageView?.layer.borderColor = UIColor.lightGray.cgColor
        cell.flagImageView?.layer.cornerRadius = 5
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            let flag = self.flags[indexPath.row]
            vc.selectedCountry = flag.country
            vc.selectedImage = flag.image3x
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
