import Vapor

public func routes(_ router: Router) throws {
    
    struct MySQLVersion: Codable {
        let version: String
    }

    router.get("sql") { req in
        return req.withPooledConnection(to: .mysql) { conn in
            return conn.raw("SELECT @@version as version")
                .all(decoding: MySQLVersion.self)
            }.map { rows in
                return rows[0].version
        }
    }
    
    router.get("article") { req -> Future<[Article]> in
        return try ArticleController.articles(req: req)
    }

    // 2chmm page
    router.get { req -> Future<View> in
        return try req.view().render("2chmm", [
            "blogs": ArticleController.blogs(req: req)
        ])
    }
}
