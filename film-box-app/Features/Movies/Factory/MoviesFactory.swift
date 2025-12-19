//
//  MoviesFactory.swift
//  film-box-app
//
//  Created by Geovane Lima on 18/12/25.
//

import UIKit

enum MoviesFactory {
    static func make() -> UIViewController {
        let viewControler = MoviesViewController()
        return viewControler
    }
}
