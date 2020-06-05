package com.airbnb3.codesquad.airbnb3.dao.hamill;

import com.airbnb3.codesquad.airbnb3.dto.hamill.PropertiesDtoHamill;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.Date;
import java.util.Arrays;
import java.util.List;

@Repository
public class PropertiesDaoHamill {

    private final Logger logger = LoggerFactory.getLogger(PropertiesDaoHamill.class);

    private final JdbcTemplate jdbcTemplate;

    public PropertiesDaoHamill(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<PropertiesDtoHamill> findAllProperties(
            Integer offset, Double priceMin, Double priceMax, Date checkIn, Date checkOut, Integer guests
            , Double minLatitude, Double minLongitude, Double maxLatitude, Double maxLongitude) {

        logger.info("#### offset, priceMin, priceMax, checkIn, checkOut, guests: {}, {}, {}, {}, {}, {}",
                offset, priceMin, priceMax, checkIn, checkOut, guests);
        logger.info("#### minLatitude, maxLatitude, minLongitude, maxLongitude: {}, {}, {}, {}",
                minLatitude, maxLatitude, minLongitude, maxLongitude);

        String sql =
                "SELECT p.id,\n" +
                        "       p.title,\n" +
                        "       p.state,\n" +
                        "       p.city,\n" +
                        "       p.latitude,\n" +
                        "       p.longitude,\n" +
                        "       p.reservable,\n" +
                        "       p.saved,\n" +
                        "       CASE p.host_type WHEN 'super' THEN 1 ELSE 0 END AS is_super_host,\n" +
                        "       p.price,\n" +
                        "       p.place_type,\n" +
                        "       p.review_average,\n" +
                        "       p.number_of_reviews,\n" +
                        "       GROUP_CONCAT(i.image_url) AS image\n" +
                        "FROM properties p\n" +
                        "         LEFT JOIN images i ON p.id = i.properties_id\n" +
                        "         LEFT JOIN detail d ON p.id = d.id\n" +
                        "         LEFT JOIN calendar c ON p.id = c.properties_id\n" +
                        "WHERE (p.price BETWEEN ? AND ?)\n" +
                        "  AND p.id NOT IN (SELECT DISTINCT properties_id FROM calendar WHERE reservation_date BETWEEN ? AND ?)\n" +
                        "  AND d.accommodates >= ?\n" +
                        "  AND p.latitude BETWEEN  ? AND ?\n" +
                        "  AND p.longitude BETWEEN  ? AND ?\n" +
                        "GROUP BY p.id\n" +
                        "LIMIT ?";

        return jdbcTemplate.query(
                sql,
                (rs, rowNum) ->
                        PropertiesDtoHamill.builder()
                                           .id(rs.getLong("id"))
                                           .title(rs.getString("title"))
                                           .state(rs.getString("state"))
                                           .city(rs.getString("city"))
                                           .latitude(rs.getDouble("latitude"))
                                           .longitude(rs.getDouble("longitude"))
                                           .reservable(rs.getBoolean("reservable"))
                                           .saved(rs.getBoolean("saved"))
                                           .isSuperHost(rs.getBoolean("is_super_host"))
                                           .price(rs.getDouble("price"))
                                           .placeType(rs.getString("place_type"))
                                           .reviewAverage(rs.getDouble("review_average"))
                                           .numberOfReviews(rs.getInt("number_of_reviews"))
                                           .images(Arrays.asList(rs.getString("image").split(",")))
                                           .build()
                , priceMin, priceMax, checkIn, checkOut, guests, minLatitude, maxLatitude, minLongitude, maxLongitude, offset);
    }
}
