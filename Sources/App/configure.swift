import Leaf
import MySQL
import FluentMySQL
import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    // Register providers first
    try services.register(LeafProvider())
    try services.register(MySQLProvider())

    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)
    
    // Use Leaf for rendering views
    config.prefer(LeafRenderer.self, for: ViewRenderer.self)

    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)
    
    // Configure a MySQL database
    let mysql = MySQLDatabase(config: MySQLDatabaseConfig(
        hostname: "127.0.0.1",
        port: 3306,
        username: "root",
        password: "sommelier",
        database: "sommelier_local",
        transport: MySQLTransportConfig.unverifiedTLS))

    /// Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: Article.self, database: .mysql)
    services.register(migrations)
    
    /// Register the configured MySQL database to the database config.
    var databases = DatabasesConfig()
    databases.add(database: mysql, as: .mysql)
    services.register(databases)
}
