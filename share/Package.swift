import PackageDescription

let package :Package = Package(
    name :"SwiftBBS",
    dependencies :[
        .Package(url: "https://github.com/qutheory/vapor.git", majorVersion: 0, minor: 6),
        .Package(url: "https://github.com/fromkk/swift_mysql.git", majorVersion :0, minor :1)
    ]
)
