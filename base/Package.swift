import PackageDescription

let package :Package = Package(
    name :"SwiftBBS",
    dependencies :[
        .Package(url: "https://github.com/qutheory/vapor.git", majorVersion: 0, minor: 6)
    ]
)
