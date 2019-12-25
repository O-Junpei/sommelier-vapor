import Vapor

public func routes(_ router: Router) throws {
    // 2chmm page
    router.get { req -> Future<View> in
        return try req.view().render("2chmm", [
            "blogs": [
                Blog(name: "クックパッド開発者ブログ", url: "https://techlife.cookpad.com/"),
                Blog(name: "クラスメソッド発「やってみた」系技術メディア | Developers.IO", url: "https://dev.classmethod.jp/")
            ]
        ])
    }
}
