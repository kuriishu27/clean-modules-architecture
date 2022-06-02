//
//  AppDelegate.swift
//  ExampleMVVM
//
//  Created by Oleh Kudinov on 01.10.18.
//

import UIKit
import Common
import Persistence

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	let appDIContainer: AppDIContainer = AppDIContainer()
	var appFlowCoordinator: AppFlowCoordinator?
	var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		AppAppearance.setupAppearance()
		
		window = UIWindow(frame: UIScreen.main.bounds)
		let navigationController = UINavigationController()
		
		window?.rootViewController = navigationController
		appFlowCoordinator = AppFlowCoordinator(navigationController: navigationController,
																						appDIContainer: appDIContainer)
		appFlowCoordinator?.start()
		window?.makeKeyAndVisible()
		
		return true
	}
	
	func applicationDidEnterBackground(_ application: UIApplication) {
		CoreDataStorage.shared.saveContext()
	}
}
