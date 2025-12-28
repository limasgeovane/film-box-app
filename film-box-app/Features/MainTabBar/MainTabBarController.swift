import UIKit

final class MainTabBarController: UITabBarController {
    private let moviesViewController = MoviesFactory.make()
    private let favoriteMoviesViewController = FavoriteMoviesFactory.make()
    
    private lazy var moviesNavigationController = UINavigationController(rootViewController: moviesViewController)
    private lazy var favoriteMoviesNavigationController = UINavigationController(rootViewController: favoriteMoviesViewController)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        setupTitles()
        setupTabBar()
        setupTabBarAppearance()
        setupViewControllers()
    }
    
    private func setupTitles() {
        moviesViewController.title =  String(localized: "movies")
        favoriteMoviesViewController.title = String(localized: "favorites")
    }
    
    private func setupTabBar() {
        tabBar.isTranslucent = false
        tabBar.barTintColor = UIColor.secondarySystemBackground
        tabBar.backgroundColor = UIColor.secondarySystemBackground
        
        moviesNavigationController.tabBarItem = UITabBarItem(
            title: String(localized: "movies"),
            image: UIImage(systemName: "film"),
            selectedImage: UIImage(systemName: "film.fill")
        )
        
        favoriteMoviesNavigationController.tabBarItem = UITabBarItem(
            title: String(localized: "favorites"),
            image: UIImage(systemName: "star"),
            selectedImage: UIImage(systemName: "star.fill")
        )
    }
    
    private func setupTabBarAppearance() {
        let primaryAppColor = UIColor(named: "primaryAppColor") ?? UIColor.systemBlue
        let secondaryAppColor = UIColor(named: "secondaryAppColor") ?? UIColor.gray
        let appearance = UITabBarAppearance()
        
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.secondarySystemBackground
        
        appearance.stackedLayoutAppearance.normal.iconColor = secondaryAppColor
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: secondaryAppColor
        ]
        
        appearance.stackedLayoutAppearance.selected.iconColor = primaryAppColor
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: primaryAppColor,
        ]
        
        tabBar.standardAppearance = appearance
    }
    
    private func setupViewControllers() {
        viewControllers = [moviesNavigationController, favoriteMoviesNavigationController]
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let navigationController = viewController as? UINavigationController {
            navigationController.popToRootViewController(animated: false)
        }
    }
}
