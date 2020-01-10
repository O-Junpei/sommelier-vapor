import FluentMySQL
import Vapor

struct Article: Codable, MySQLModel {
    var id: Int?
    static let entity = "article"  // テーブル名
    
    
    var article_id: Int?
    var title: String?
    var article_url: String?
    var site_name: String?
    var site_url: String?
    
    
//    enum CodingKeys: String, CodingKey {
////      case name
////      case age
////      case friends
//      case article_url = "article_url"  // ←　これ
//    }
}

extension Article: Content { }
extension Article: Migration { }
