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
    
    // 2chmm page
    router.get { req -> Future<View> in
        return try req.view().render("2chmm", [
            "blogs": [
                Blog(
                    name: "クックパッド開発者ブログ",
                    url: "https://techlife.cookpad.com/",
                    articles: [
                        Article(
                            title: "Amazon Elasticsearch ServiceをつかったRDSのスロークエリの集計と監視",
                            url: "https://techlife.cookpad.com/entry/2019/12/27/000000"),
                        Article(
                            title: "プロと読み解くRuby 2.7 NEWS",
                            url: "https://techlife.cookpad.com/entry/2019/12/25/121834"),
                        Article(
                            title: "センサクッキング 技術検証とユーザー体験検証",
                            url: "https://techlife.cookpad.com/entry/2019/12/18/110000")]),
                Blog(
                    name: "クラスメソッド発「やってみた」系技術メディア | Developers.IO",
                    url: "https://dev.classmethod.jp/",
                    articles: [
                        Article(
                            title: "[小ネタ]WorkSpacesのディレクトリが消せないし理由も分からない？そんな時はAWS Directory Serviceを見てみよう",
                            url: "https://dev.classmethod.jp/cloud/aws/how-to-delete-ad-for-workspaces-and-find-the-cause/"),
                        Article(
                            title: "[レポート] 可観測性は AI ・メトリクス・ログの幸せな結婚を夢見るか？ AIOps の雄、Moogsoft の CEO が語る #AIM310 #reinvent",
                            url: "https://dev.classmethod.jp/cloud/aws/201912-report-reinvent-2019-aim310/"),
                        Article(
                            title: "[レポート] Container Insight, FireLens, AppMesh を使ってコンテナ環境 (ECS/EKS/Fargate) の可観測性を向上させる #CON328 #reinvent",
                            url: "https://dev.classmethod.jp/cloud/aws/201912-report-reinvent-2019-con328/")
                ])
            ]
        ])
    }
}
