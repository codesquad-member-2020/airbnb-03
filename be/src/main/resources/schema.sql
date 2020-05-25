drop table if exists properties;
drop table if exists bookings;
drop table if exists user;
drop table if exists detail;
drop table if exists bookmarks;
drop table if exists images;

create table if not exists properties
(
    id                INT,
    title             VARCHAR(64),
    state             VARCHAR(64),
    city              VARCHAR(64),
    address           VARCHAR(128) DEFAULT 'Not Address',
    latitude          DOUBLE,
    longitude         DOUBLE,
    reservable        BOOLEAN,
    saved             BOOLEAN,
    host_type         VARCHAR(32)  DEFAULT 'Not Tag',
    price             DECIMAL(10, 3),
    place_type        VARCHAR(32),
    review_average    DECIMAL(3, 2),
    number_of_reviews INT,
    primary key (id)
);

create table if not exists bookings
(
    id                INT AUTO_INCREMENT,
    check_in_date     DATETIME,
    check_out_date    DATETIME,
    booking_date      DATETIME,
    cleaning_fee      DECIMAL(10, 3),
    service_fee       DECIMAL(10, 3),
    occupancy_tax_fee DECIMAL(10, 3),
    booking_price     DECIMAL(10, 3),
    status            BOOLEAN,
    properties_id     INT REFERENCES properties (id),
    user_id           INT REFERENCES user (id),
    primary key (id)
);

create table if not exists user
(
    id    INT AUTO_INCREMENT,
    name  VARCHAR(64),
    email VARCHAR(128),
    primary key (id)
);

create table if not exists detail
(
    id                          INT,
    summary                     VARCHAR(1024),
    space                       VARCHAR(1024),
    city_overview               VARCHAR(1024),
    notes                       VARCHAR(1024),
    transit                     VARCHAR(1024),
    host_name                   VARCHAR(64),
    host_since                  DATE,
    host_location               VARCHAR(128),
    host_about                  VARCHAR(5000),
    address                     VARCHAR(128),
    accommodates                INT,
    bathrooms                   INT,
    bedrooms                    INT,
    beds                        INT,
    bed_type                    VARCHAR(128),
    amenities                   VARCHAR(512),
    service_fee                 DOUBLE,
    cleaning_fee                DOUBLE,
    tax                         DOUBLE,
    review_scores_accuracy      DECIMAL(2,1),
    review_scores_cleanliness   DECIMAL(2,1),
    review_scores_checkin       DECIMAL(2,1),
    review_scores_communication DECIMAL(2,1),
    review_scores_location      DECIMAL(2,1),
    review_scores_value         DECIMAL(2,1),
    primary key (id)
);

create table if not exists bookmarks
(
    id            INT AUTO_INCREMENT,
    is_bookmarked BOOLEAN,
    user_id       INT REFERENCES user (id),
    properties_id INT REFERENCES properties (id),
    primary key (id)
);

create table if not exists images
(
    id            INT AUTO_INCREMENT,
    image_url     VARCHAR(256),
    properties_id INT REFERENCES properties (id),
    primary key (id)
);
