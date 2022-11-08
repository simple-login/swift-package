// swift-tools-version:5.7
//
//  Swift_PackageTests.swift
//  Swift PackageTests
//
//  Created by Thanh-Nhon Nguyen on 30/05/2021.
//

import PackageDescription

let package = Package(
    name: "SimpleLoginPackage",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [
        .library(name: "SimpleLoginPackage", targets: ["SimpleLoginPackage"]),
    ],
    targets: [
        .target(
            name: "SimpleLoginPackage",
            dependencies: []),
    ]
)
