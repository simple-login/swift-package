// swift-tools-version:5.4.0
//
//  Swift_PackageTests.swift
//  Swift PackageTests
//
//  Created by Thanh-Nhon Nguyen on 30/05/2021.
//

import PackageDescription

let package = Package(
    name: "SimpleLoginPackage",
    platforms: [
        .macOS(.v10_15), .iOS(.v13),
    ],
    products: [
        .library(name: "SimpleLoginPackage", targets: ["SimpleLoginPackage"]),
    ],
    targets: [
        .target(
            name: "SimpleLoginPackage",
            dependencies: []),
        .testTarget(
            name: "Swift PackageTests",
            dependencies: ["SimpleLoginPackage"]),
    ]
)