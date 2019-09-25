//
//  TabCoordinator.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 13/06/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

enum ViewControllerItem: Int {
    case translator = 0
    case meteo = 1
    case converter = 2
}

protocol TabBarSourceType {
    var items : [UINavigationController] { get set }
}

final private class TabBarSource: TabBarSourceType {
    var items: [UINavigationController] = [
        UINavigationController(nibName: nil, bundle: nil),
        UINavigationController(nibName: nil, bundle: nil),
        UINavigationController(nibName: nil, bundle: nil)
    ]
    
    init() {
        items[0].tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 0)
        items[1].tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
        items[2].tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
    }
}

extension TabBarSourceType {
    subscript(item: ViewControllerItem) -> UINavigationController {
        get {
            guard !items.isEmpty, item.rawValue < items.count, item.rawValue >= 0 else {
                fatalError("Item does not exist")
            }
            return items[item.rawValue]
        }
    }
}

final class TabCoordinator: NSObject {
    
    // MARK: - Properties
    
    private let presenter: UIWindow
    
    private let tabBarController: UITabBarController
    
    private let screens: Screens
    
    private var translatorCoordinator: TranslatorCoordinator?
    
    private var meteoCoordinator: MeteoCoordinator?
    
    private var converterCoordinator: ConverterCoordinator?
    
    private var source: TabBarSource = TabBarSource()
    
    // MARK: - Initializer
    
    init(presenter: UIWindow) {
        self.presenter = presenter
        
        screens = Screens()
        tabBarController = UITabBarController(nibName: nil, bundle: nil)
        tabBarController.viewControllers = source.items
        tabBarController.selectedViewController = source[.translator]
        super.init()
        
        tabBarController.delegate = self
    }
    
    func start() {
        presenter.rootViewController = tabBarController
        showTranslator()
    }
    
    private func showTranslator() {
        translatorCoordinator = TranslatorCoordinator(presenter: source[.translator], screens: screens)
        translatorCoordinator?.start()
    }
    
    private func showMeteo() {
        meteoCoordinator = MeteoCoordinator(presenter: source[.meteo], screens: screens)
        meteoCoordinator?.start()
    }
    
    private func showConverter() {
        converterCoordinator = ConverterCoordinator(presenter: source[.converter], screens: screens)
        converterCoordinator?.start()
    }
    
}

extension TabCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let index = tabBarController.selectedIndex
        guard index < source.items.count, let item = ViewControllerItem(rawValue: index) else {
            fatalError("Index out of Range")
        }
        
        switch item {
        case .translator:
            showTranslator()
        case .meteo:
            showMeteo()
        case .converter:
            showConverter()
        }
    }
}
