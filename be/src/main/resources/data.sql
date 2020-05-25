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
