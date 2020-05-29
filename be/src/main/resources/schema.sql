DROP TABLE IF EXISTS calendar;
DROP TABLE IF EXISTS images;
DROP TABLE IF EXISTS bookmarks;
DROP TABLE IF EXISTS detail;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS properties;

CREATE TABLE IF NOT EXISTS properties
(
    id                INT,
    title             VARCHAR(64),
    state             VARCHAR(64),
    city              VARCHAR(64),
    latitude          DOUBLE,
    longitude         DOUBLE,
    reservable        BOOLEAN,
    saved             BOOLEAN,
    host_type         VARCHAR(32) DEFAULT 'Not Tag',
    price             DECIMAL(10, 3),
    place_type        VARCHAR(32),
    review_average    DECIMAL(3, 2),
    number_of_reviews INT,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS bookings
(
    id             INT AUTO_INCREMENT,
    check_in_date  DATE,
    check_out_date DATE,
    booking_date   DATETIME,
    guests         INT,
    cleaning_fee   DECIMAL(10, 3),
    service_fee    DECIMAL(10, 3),
    tax            DECIMAL(10, 3),
    price          DECIMAL(10, 3),
    price_per_stay DECIMAL(10, 3),
    total_price    DECIMAL(10, 3),
    nights         INT,
    properties_id  INT REFERENCES properties (id),
    user_id        INT REFERENCES user (id),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS user
(
    id    INT,
    name  VARCHAR(64),
    email VARCHAR(128),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS detail
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
    review_scores_accuracy      DECIMAL(2, 1),
    review_scores_cleanliness   DECIMAL(2, 1),
    review_scores_checkin       DECIMAL(2, 1),
    review_scores_communication DECIMAL(2, 1),
    review_scores_location      DECIMAL(2, 1),
    review_scores_value         DECIMAL(2, 1),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS bookmarks
(
    id            INT AUTO_INCREMENT,
    is_bookmarked BOOLEAN,
    user_id       INT REFERENCES user (id),
    properties_id INT REFERENCES properties (id),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS images
(
    id            INT AUTO_INCREMENT,
    image_url     VARCHAR(256),
    properties_id INT REFERENCES properties (id),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS calendar
(
    id               INT AUTO_INCREMENT,
    reservation_date DATE,
    properties_id    INT REFERENCES properties (id),
    PRIMARY KEY (id)
);
