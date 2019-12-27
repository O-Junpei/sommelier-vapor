struct Blog: Encodable {
    let name: String
    let url: String
    let articles: [Article]
}
