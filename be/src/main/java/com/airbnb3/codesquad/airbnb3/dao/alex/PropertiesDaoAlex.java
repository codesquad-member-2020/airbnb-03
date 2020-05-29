package com.airbnb3.codesquad.airbnb3.dao;

import com.airbnb3.codesquad.airbnb3.dto.PropertiesDtoAlex;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

@Repository
public class PropertiesDaoAlex {

    private static final Logger logger = LoggerFactory.getLogger(PropertiesDaoAlex.class);

    @Autowired
    private NamedParameterJdbcTemplate jdbcTemplate;

    public List<PropertiesDtoAlex> getStayedProperties(int propertyRange, int accommodates,
                                                       Date checkInDate, Date checkOutDate,
                                                       Double minPrice, Double maxPrice, Map<String, Double> location) {
        String sql = "select p.id,p.title,p.state,p.city,p.latitude,p.longitude,p.reservable,p.saved,CASE p.host_type WHEN 'super' THEN 1 ELSE 0 END AS is_super_host,p.price,p.place_type,p.review_average,p.number_of_reviews, GROUP_CONCAT(DISTINCT i.image_url) AS image " +
                "FROM properties p LEFT JOIN images i ON p.id = i.properties_id " +
                "LEFT JOIN detail t ON t.id = p.id LEFT JOIN calender c ON c.properties_id = p.id " +
                "WHERE t.accommodates >= :accommodates " +
                "AND p.id NOT IN (SELECT DISTINCT properties.id FROM properties LEFT JOIN calender ON properties.id = calender.properties_id " +
                "WHERE calender.reservation_date BETWEEN :checkInDate AND :checkOutDate) " +
                "AND p.latitude BETWEEN :minLatitude AND :maxLatitude " +
                "AND p.longitude BETWEEN :minLongitude AND :maxLongitude " +
                "AND p.price BETWEEN :minPrice AND :maxPrice " +
                "GROUP BY p.id LIMIT :propertyRange";

        MapSqlParameterSource parameterSource = new MapSqlParameterSource()
                .addValue("propertyRange", propertyRange)
                .addValue("accommodates", accommodates)
                .addValue("checkInDate", checkInDate)
                .addValue("checkOutDate", checkOutDate)
                .addValue("minPrice", minPrice)
                .addValue("maxPrice", maxPrice)
                .addValue("minLatitude", location.get("minLatitude"))
                .addValue("maxLatitude", location.get("maxLatitude"))
                .addValue("minLongitude", location.get("minLongitude"))
                .addValue("maxLongitude", location.get("maxLongitude"));

        return jdbcTemplate.query(sql, parameterSource, (rs, rowNum) -> PropertiesDtoAlex.builder()
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
                .build());
    }

}

