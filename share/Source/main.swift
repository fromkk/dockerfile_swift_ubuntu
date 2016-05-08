import Vapor
import SwiftMysql

let connection :MysqlConnection = MysqlConnection(host: "localhost", user :"root", password :"password", port: 3306, database : "bbs")
do
{
    try connection.open()
} catch {
    print("connection error")
}

let app :Application = Application()
app.get("/") { request in

    let queryBuilder :MysqlSelectQueryBulder = MysqlSelectQueryBulder.select(table :"bbs")
    var results :MysqlResult?
    do
    {
        results = try connection.execute(sql :queryBuilder.query())
    } catch
    {
        print("select failed")
    }

    return "Hello world \(results?.rows)"
}
app.get("hello") { request in
    return "Hello world"
}
app.get("create") { request in
    let sql :String = "CREATE TABLE IF NOT EXISTS bbs ("
                    + "id INTEGER PRIMARY KEY AUTO_INCREMENT,"
                    + "name VARCHAR(255) NOT NULL,"
                    + "content TEXT NOT NULL,"
                    + "created_at DOUBLE,"
                    + "updated_at DOUBLE NULL,"
                    + "deleted_at DOUBLE NULL)"
    do
    {
        try connection.execute(sql :sql)
    } catch
    {
        print("create table failed")
    }

    return "create!!"
}
app.get("insert") { request in
    let sql :String = "INSERT INTO bbs (name, content, created_at) VALUES ('マルチバイト文字', 'bbs content', 0)"
    do
    {
        try connection.execute(sql :sql)
    } catch
    {
        print("insert failed")
    }

    return "insert!!"
}
app.start(port :8090)
