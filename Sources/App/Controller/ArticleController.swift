import Vapor
import FluentMySQL

final class ArticleController {
    
    static func articles(req: Request) throws -> Future<[Article]> {
        return Article.query(on: req).all()
    }
    
    static func blogs(req: Request) throws -> Future<[Blog]> {
        let cookpadArticles: Future<[Article]> = Article.query(on: req).filter(\.siteUrl == "https://techlife.cookpad.com") .all()
        let classmethodArticles: Future<[Article]> = Article.query(on: req).filter(\.siteUrl == "https://dev.classmethod.jp") .all()
        
        let blogs = map(cookpadArticles, classmethodArticles) { (cookpadArticles, classmethodArticles) -> ([Blog]) in
            let cookpadBlog = Blog(name: "クックパッド開発者ブログ", url: "https://techlife.cookpad.com", articles: cookpadArticles)
            let classmethodBlog = Blog(name: "クラスメソッド発「やってみた」系技術メディア | Developers.IO", url: "https://dev.classmethod.jp", articles: classmethodArticles)
            return [cookpadBlog, classmethodBlog]
        }
        return blogs
    }
}
