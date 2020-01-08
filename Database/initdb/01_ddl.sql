create table article(
    article_id int(11) not null auto_increment,
    title varchar(255),
    article_url varchar(255),
    site_name varchar(255),
    site_url varchar(255),
    primary key (article_id)
);
