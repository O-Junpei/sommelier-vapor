import FluentMySQL
import Vapor

struct Article: Encodable, MySQLModel {
    var id: Int?
     static let entity = "article"  // テーブル名

     var article_id: Int?
     var title: String?
     var article_url: String?
}

extension Article: Content { }
extension Article: Migration { }
