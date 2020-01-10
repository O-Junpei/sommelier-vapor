import Vapor
import FluentMySQL

final class ArticleController {

    static func articles(req: Request) throws -> Future<[Article]> {
        return Article.query(on: req).all()
    }
    
    static func blogs(req: Request) throws -> Future<[Blog]> {
        let articles: Future<[Article]> = Article.query(on: req).all()
        let blogs = articles.map { (articles) -> ([Blog]) in
            let xxx = Blog(name: "クックパッド開発者ブログ", url: "https://techlife.cookpad.com", articles: articles)
            return [xxx]
        }
        return blogs
    }
}
