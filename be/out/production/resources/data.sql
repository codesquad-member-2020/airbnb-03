LOAD DATA INFILE 'properties.csv'
INTO TABLE airbnb_a.properties
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id,host_type,title,city,state,latitude,longitude,reservable,price,place_type,review_average,number_of_reviews,saved);

LOAD DATA INFILE 'images.csv'
INTO TABLE airbnb_a.images
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(image_url,properties_id);

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
