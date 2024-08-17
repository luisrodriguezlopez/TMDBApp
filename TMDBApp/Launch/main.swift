//
//  Main.swift
//  TMDBAppTests
//
//  Created by luis rodriguez on 15/08/24.
//
import UIKit
@testable import TMDBApp

let appDelegateClass: AnyClass =
NSClassFromString("TestingAppDelegate") ?? AppDelegate.self

UIApplicationMain(
    CommandLine.argc,
    CommandLine.unsafeArgv,
    nil,
    NSStringFromClass(appDelegateClass))
