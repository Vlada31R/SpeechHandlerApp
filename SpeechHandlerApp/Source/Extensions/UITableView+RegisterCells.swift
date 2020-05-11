//
//  UITableView+RegisterCells.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/11/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

import UIKit

extension UITableView: ClassNameProtocol {

    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T where T: ClassNameProtocol {

        guard let cell = self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as? T
        else {
            fatalError("Couldn't load cell with identifier \(type.className)")
        }
        return cell
    }

    func register<T: UITableViewCell>(cellType: T.Type, bundle: Bundle? = nil) where T: ClassNameProtocol {

        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellReuseIdentifier: className)
    }
}
