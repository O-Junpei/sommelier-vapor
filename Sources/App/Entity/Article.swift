import FluentMySQL
import Vapor

struct Article: Decodable, MySQLModel {
    var id: Int?
    static let entity = "article"  // テーブル名
    
    var articleId: Int?
    var title: String?
    var articleUrl: String?
    var site_name: String?
    var siteUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case articleId = "article_id"
        case title = "title"
        case articleUrl = "article_url"
        case site_name = "site_name"
        case siteUrl = "site_url"
    }
}

extension Article: Content { }
extension Article: Migration { }
