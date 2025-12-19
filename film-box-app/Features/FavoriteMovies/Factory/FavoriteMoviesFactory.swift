//
//  FavoriteMoviesFactory.swift
//  film-box-app
//
//  Created by Geovane Lima on 18/12/25.
//

import UIKit

enum FavoriteMoviesFactory {
    static func make() -> UIViewController {
        let viewControler = FavoriteMoviesViewController()
        return viewControler
    }
}
