// Properties init Data sql
LOAD DATA LOCAL INFILE '/home/airbnb/project/data/properties.csv'
INTO TABLE airbnb_a.properties
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id,host_type,title,city,state,latitude,longitude,reservable,price,place_type,review_average,number_of_reviews,saved);

// images init Data sql
LOAD DATA LOCAL INFILE '/home/airbnb/project/data/images.csv'
INTO TABLE airbnb_a.images
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(image_url,properties_id);
