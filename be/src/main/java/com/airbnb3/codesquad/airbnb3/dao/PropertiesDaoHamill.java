package com.airbnb3.codesquad.airbnb3.dao;

import com.airbnb3.codesquad.airbnb3.dto.PropertiesDtoHamill;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.Arrays;
import java.util.List;

@Repository
public class PropertiesDaoHamill {

    private final Logger logger = LoggerFactory.getLogger(PropertiesDaoHamill.class);

    private final JdbcTemplate jdbcTemplate;

    public PropertiesDaoHamill(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<PropertiesDtoHamill> findAllProperties(int page) {
        return jdbcTemplate.query(
                        "SELECT p.id, p.title, p.state, p.city, p.address, p.latitude, p.longitude, p.reservable," +
                        "p.saved,p.host_type,p.price,p.place_type,p.review_average,p.number_of_reviews, GROUP_CONCAT(i.image_url) AS image " +
                        "FROM properties p LEFT JOIN images i ON p.id = i.properties_id WHERE p.id < ? GROUP BY p.id",
                (rs, rowNum) ->
                        PropertiesDtoHamill.builder()
                                           .id(rs.getLong("id"))
                                           .title(rs.getString("title"))
                                           .state(rs.getString("state"))
                                           .city(rs.getString("city"))
                                           .address(rs.getString("address"))
                                           .latitude(rs.getDouble("latitude"))
                                           .longitude(rs.getDouble("longitude"))
                                           .reservable(rs.getBoolean("reservable"))
                                           .saved(rs.getBoolean("saved"))
                                           .hostType(rs.getString("host_type"))
                                           .price(rs.getDouble("price"))
                                           .placeType(rs.getString("place_type"))
                                           .reviewAverage(rs.getDouble("review_average"))
                                           .numberOfReviews(rs.getInt("number_of_reviews"))
                                           .images(imageParser(rs.getString("image")))
                                           .build()
        , page);
    }

    private List<String> imageParser(String images) {
        String[] image = images.split(",");
        return Arrays.asList(image);
    }
}
