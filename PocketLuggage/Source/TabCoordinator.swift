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
        tabBarIconInitializer()
    }
    
    private func tabBarIconInitializer() {
        let translatorIcon = UIImage(systemName: "bubble.left.and.bubble.right")
        let filledTranslatorIcon = UIImage(systemName: "bubble.left.and.bubble.right.fill")
        self[.translator].tabBarItem = UITabBarItem(title: "Translator", image: translatorIcon, selectedImage: filledTranslatorIcon)
        let meteoIcon = UIImage(systemName: "sun.min")
        let filledMeteoIcon = UIImage(systemName: "sun.min.fill")
        self[.meteo].tabBarItem = UITabBarItem(title: "Weather", image: meteoIcon, selectedImage: filledMeteoIcon)
        let converterIcon = UIImage(systemName: "dollarsign.circle")
        let filledConverterIcon = UIImage(systemName: "dollarsign.circle.fill")
        self[.converter].tabBarItem = UITabBarItem(title: "Converter", image: converterIcon, selectedImage: filledConverterIcon)
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
    
    // MARK: - Init

    init(presenter: UIWindow, context: Context) {
        self.presenter = presenter
        self.screens = Screens(context: context)
        
        tabBarController = UITabBarController(nibName: nil, bundle: nil)
        tabBarController.viewControllers = source.items
        tabBarController.selectedViewController = source[.translator]
        super.init()
        
        tabBarController.delegate = self
    }

    // MARK: - Start
    
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
