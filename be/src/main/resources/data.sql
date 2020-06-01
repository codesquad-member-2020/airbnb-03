LOAD DATA INFILE 'properties.csv'
INTO TABLE airbnb.properties
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id,host_type,title,city,state,latitude,longitude,reservable,price,place_type,review_average,number_of_reviews,saved);

LOAD DATA INFILE 'properties_detail.csv'
INTO TABLE airbnb.detail
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'images.csv'
INTO TABLE airbnb.images
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(image_url,properties_id);

INSERT INTO user (id, name, email) VALUES (1, 'hamill', 'hamill@gmail.com');
INSERT INTO user (id, name, email) VALUES (2, 'alex', 'haveagood@github.com');
INSERT INTO user (id, name, email) VALUES (3, 'cory', 'corykim@github.com');
INSERT INTO user (id, name, email) VALUES (4, 'mos', 'dongjunkim@github.com');

-- LOAD DATA INFILE '/Users/choi/Desktop/java/airbnb-03/be/src/main/resources/data/properties.csv'
-- INTO TABLE airbnb_a.properties
-- FIELDS TERMINATED BY ','
-- ENCLOSED BY '"'
-- LINES TERMINATED BY '\n'
-- IGNORE 1 ROWS
-- (id,host_type,title,city,state,latitude,longitude,reservable,price,place_type,review_average,number_of_reviews,saved);
--
-- LOAD DATAINFILE '/Users/choi/Desktop/java/airbnb-03/be/src/main/resources/data/properties.csv'
-- INTO TABLE airbnb_a.images
-- FIELDS TERMINATED BY ','
-- ENCLOSED BY '"'
-- LINES TERMINATED BY '\n'
-- (image_url,properties_id);
