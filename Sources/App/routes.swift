import Vapor

public func routes(_ router: Router) throws {
    // 2chmm page
    router.get { req -> Future<View> in
        return try req.view().render("2chmm", [
            "sites": ["クックパッド開発者ブログ", "クラスメソッド発「やってみた」系技術メディア | Developers.IO"]
        ])
    }
}
