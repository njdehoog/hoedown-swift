import PackageDescription

let package = Package(
    name: "Hoedown",
    targets: [
        Target(
            name: "Hoedown",
            dependencies: ["CHoedown"]),
        Target(
            name: "CHoedown",
            dependencies: [])
    ]
)
